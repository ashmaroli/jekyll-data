# encoding: UTF-8
require "csv"

module Jekyll
  class ThemeReader < Reader
    def initialize(site)
      @site = site
      @theme_data_files = Dir[File.join(@site.theme.root,
        site.config["data_dir"], "**", "*.{yaml,yml,json,csv}")]
    end

    # Read Site data from disk and load it into internal data structures.
    #
    # Returns nothing.
    def read
      @site.layouts = LayoutReader.new(site).read
      read_directories
      sort_files!
      @site.data = DataReader.new(site).read(site.config["data_dir"])
      read_theme_data
      CollectionReader.new(site).read
      ThemeAssetsReader.new(site).read
    end

    # Read data files within a theme gem and add them to internal data
    #
    # Returns a hash appended with new data
    def read_theme_data
      if site.theme && site.theme.data_path
        #
        # show contents of "<theme>/_data/" dir being read
        inspect_theme_data
        theme_data = ThemeDataReader.new(site).read(site.config["data_dir"])
        @site.data = Utils.deep_merge_hashes(theme_data, @site.data)
        #
        # show site.data hash contents
        inspect_merged_hash
      end
    end

    private

    def inspect_theme_data
      print_clear_line
      print "Reading:", "Theme Data Files..."
      @theme_data_files.each do |file|
        if File.basename(file, ".*") == @site.theme.name
          inspect_theme_config file
          print_value file.green
        else
          print_value file
        end
      end
      print_clear_line
      print "Merging:", "Theme Data Hash..."
    end

    def inspect_merged_hash
      print "Inspecting:", "Site Data >>"
      inspect_hash @site.data
      print_clear_line
    end

    def inspect_hash(hash)
      hash.each do |key, value|
        print_key key
        if key == @site.theme.name
          validate_config_hash value
        end

        if value.is_a? Hash
          inspect_inner_hash value
        elsif value.is_a? Array
          print_label key
          extract_hashes_and_print value
        else
          print_value "'#{value}'"
        end
      end
    end

    def inspect_inner_hash(hash)
      hash.each do |key, value|
        if value.is_a? Array
          print_label key
          extract_hashes_and_print value
          print_clear_line
        elsif value.is_a? Hash
          print_subkey_and_value key, value
        else
          print_hash key, value
        end
      end
    end

    def extract_hashes_and_print(array)
      array.each do |entry|
        if entry.is_a? String
          print "-", entry
        else
          inspect_inner_hash entry
        end
      end
    end

    def inspect_theme_config(path)
      config = ThemeDataReader.new(site).read_data_file(path)
      validate_config_hash config
    end

    def validate_config_hash(value)
      if value == false
        abort_with_msg "Cannot define or override Theme Configuration " \
                       "with an empty file!"
      end
      unless value.is_a? Hash
        abort_with_msg "Theme Config or its override should be a Hash of " \
            "key:value pairs or mappings. But got #{value.class} instead."
      end
    end

    def print_hash(key, value)
      print "#{key}:", value
    end

    def print_key(key)
      @dashes = "------------------------"
      print_value @dashes.to_s.cyan
      print "Data Key:", key.to_s.cyan
      print_value @dashes.to_s.cyan
    end

    def print_subkey_and_value(key, value)
      print_label key
      value.each do |subkey, val|
        print_hash subkey, val
      end
      print_dashes
    end

    def print_value(value)
      if value.is_a? Array
        extract_hashes_and_print value
      else
        print "", value
      end
    end

    def print_label(key)
      print "#{key}:"
    end

    def print_dashes
      print "", @dashes
    end

    def print_clear_line
      print ""
    end

    def print(arg1, arg2 = "")
      Jekyll.logger.debug arg1, arg2
    end

    def abort_with_msg(msg)
      Jekyll.logger.abort_with "JekyllData:", msg
    end
  end
end
