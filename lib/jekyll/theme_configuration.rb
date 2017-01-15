# encoding: UTF-8

module Jekyll
  class ThemeConfiguration < Configuration
    # Public: Read configuration file and return extracted Hash
    #
    # file - the _config.yml within theme-gem to be read in
    #
    # Returns a Hash
    def read_config(file)
      config = safe_load_file(file)
      check_config_is_hash!(config, file)
      Jekyll.logger.info "Theme Config file:", file

      config
    end
  end
end
