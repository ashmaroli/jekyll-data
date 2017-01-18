require "jekyll"
require "jekyll-data/version"

# Plugin inclusions
require_relative "jekyll/theme_reader"
require_relative "jekyll/theme_configuration"
require_relative "jekyll/readers/theme_data_reader"
require_relative "jekyll/drops/themed_site_drop"

# Monkey-patches
require_relative "jekyll/theme"
require_relative "jekyll/drops/unified_payload_drop"

# replace Jekyll::Reader with a subclass Jekyll::ThemeReader only if the site
# uses a gem-based theme else have this plugin disabled.
#
# Additionally, if a '_config.yml' is present in the theme-gem, it is evaluated
# and the extracted hash data is incorprated into the site's config hash.
Jekyll::Hooks.register :site, :after_init do |site|
  if site.theme
    site.reader = Jekyll::ThemeReader.new(site)

    if File.exist?(site.in_theme_dir("_config.yml"))
      site.config = Jekyll::ThemeConfiguration.reconfigure(site)
    end

  else
    Jekyll.logger.abort_with(
      "JekyllData:",
      "Error! This plugin only works with gem-based jekyll-themes. " \
      "Please disable this plugin to proceed."
    )
  end
end
