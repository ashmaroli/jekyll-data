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
# Additionally, append to site's config hash with optional config hash from the
# theme gem by filling in keys not already defined.
Jekyll::Hooks.register :site, :after_init do |site|
  if site.theme
    site.config = Jekyll::Utils.deep_merge_hashes(
      Jekyll::ThemeReader.new(site).read_theme_config, site.config
    )
    site.reader = Jekyll::ThemeReader.new(site)
  else
    Jekyll.logger.abort_with(
      "JekyllData:",
      "Error! This plugin only works with gem-based jekyll-themes. " \
      "Please disable this plugin to proceed."
    )
  end
end
