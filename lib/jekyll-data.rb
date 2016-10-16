require "jekyll"
require "jekyll-data/version"

# Plugin inclusions
require_relative "jekyll/theme_reader"
require_relative "jekyll/readers/theme_data_reader"
require_relative "jekyll/drops/themed_site_drop"

# Monkey-patches
require_relative "jekyll/theme"
require_relative "jekyll/drops/unified_payload_drop"

# replace Jekyll::Reader with a subclass Jekyll::ThemeReader
Jekyll::Hooks.register :site, :after_init do |site|
  site.reader = Jekyll::ThemeReader.new(site)
end
