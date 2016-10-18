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
        debug_theme_reader
        theme_data = ThemeDataReader.new(site).read(site.config["data_dir"])
        @site.data = Utils.deep_merge_hashes(theme_data, @site.data)
        #
        # show site.data hash contents
        debug_theme_data_reader
      end
    end


    private

    def debug_theme_reader
      print_clear_line
      print "Reading:", "Theme Data Files..."
      @theme_data_files.each do |file|
        print_value file
      end
      print_clear_line
      print "Merging:", "Theme Data Hash..."
    end

    def debug_theme_data_reader
      print_clear_line
      print "Site Data:"
      process_hash @site.data
      print_clear_line
    end

    def process_hash(hash)
      hash.each do |key, value|
        print_key key
        if value.class == Hash
          process_inner_hash value
        else
          print_value "'#{value}'"
        end
      end
    end

    def process_inner_hash(hash)
      hash.each do |key, value|
        if value.class == Array
          print_label key
          extract_hashes_and_print value
          print_dashes
        elsif value.class == Hash
          print_subkey_and_value key, value
        else
          print_hash key, value
        end
      end
    end

    def extract_hashes_and_print(array)
      array.each do |h|
        process_inner_hash h
      end
    end

    def print_hash(key, value)
      key = key.to_s + ":"
      print key, value
    end

    def print_key(key)
      @dashes = "------------------------"
      print_value @dashes.to_s.cyan
      print "Data Key:", key.to_s.cyan
      print_value @dashes.to_s.cyan
    end

    def print_subkey_and_value(key, value)
      print_label key
      print_dashes
      value.each do |subkey, val|
        print_hash subkey, val
      end
      print_dashes
    end

    def print_value(value)
      if value.class == Array
        extract_hashes_and_print value
      else
        print "", value
      end
    end

    def print_label(key)
      print "#{key.to_s}:"
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
  end
end
