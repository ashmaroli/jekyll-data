require "jekyll"
require "jekyll-data/version"

# Plugin inclusions
require_relative "jekyll/theme_reader"
require_relative "jekyll/readers/theme_data_reader"
require_relative "jekyll/drops/themed_site_drop"

# Monkey-patches
require_relative "jekyll/theme"
require_relative "jekyll/drops/unified_payload_drop"

# replace Jekyll::Reader with a subclass Jekyll::ThemeReader only if the site
# uses a gem-based theme else have this plugin disabled.
Jekyll::Hooks.register :site, :after_init do |site|
  if site.theme
    site.reader = Jekyll::ThemeReader.new(site)
  else
    Jekyll.logger.abort_with(
      "JekyllData:",
      "Error! This plugin only works with gem-based jekyll-themes. " \
      "Please disable this plugin to proceed."
    )
  end
end
