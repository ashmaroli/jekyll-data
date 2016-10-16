# encoding: UTF-8
require "csv"

module Jekyll
  class ThemeReader < Reader
    def initialize(site)
      @site = site
      @theme_data_files = Dir[File.join(@site.theme.root, site.config["data_dir"], "/*")]
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
      Jekyll.logger.debug ""
      Jekyll.logger.debug "Reading:", "Theme Data Files..."
      
      @theme_data_files.each do | file |
        Jekyll.logger.debug "", file
      end
      
      Jekyll.logger.debug ""
      Jekyll.logger.debug "Merging:", "Theme Data Hash..."
    end

    def debug_theme_data_reader
      Jekyll.logger.debug ""
      Jekyll.logger.debug "Site Data:"
      theme = site.config["theme"]
      @site.data.each do | key, value |
        unless key == theme
          print_key key
          print_value value
        end
      end
      Jekyll.logger.debug ""
    end

    def print_key(key)
      dashes = "------------------------"
      key = key.to_s

      Jekyll.logger.debug "", dashes
      Jekyll.logger.debug "", key
      Jekyll.logger.debug "", dashes
    end

    def print_value(value)
      if value.class == Array
        value.each do | entry |
          entry.each do | k, v |
            print_hash k, v
          end
        end
      elsif value.class == Hash
        value.each do | k, v |
          print_hash k, v
        end
      end
    end

    def print_hash(key, value)
      key = key.to_s + ":"
      Jekyll.logger.debug key, value
    end
  end
end
