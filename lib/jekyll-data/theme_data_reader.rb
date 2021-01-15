# frozen_string_literal: true

module JekyllData
  class ThemeDataReader < Jekyll::DataReader
    attr_reader :site, :content

    def initialize(site)
      super

      @source_dir = site.in_theme_dir("/")
    end

    def read(dir)
      return unless site.theme && site.theme.data_path

      base = site.in_theme_dir(dir)
      read_data_to(base, @content)
      @content
    end

    def read_data_to(dir, data)
      return unless File.directory?(dir) && !@entry_filter.symlink?(dir)

      entries = Dir.chdir(dir) do
        Dir["*.{yaml,yml,json,csv,tsv}"] + Dir["*"].select { |fn| File.directory?(fn) }
      end

      entries.each do |entry|
        path = @site.in_theme_dir(dir, entry)
        next if @entry_filter.symlink?(path)

        if File.directory?(path)
          read_data_to(path, data[sanitize_filename(entry)] = {})
        else
          key = sanitize_filename(File.basename(entry, ".*"))
          data[key] = read_data_file(path)
        end
      end
    end
  end
end
