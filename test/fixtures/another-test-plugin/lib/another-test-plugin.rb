require "jekyll"

# code abstracted from the official 'jekyll-feed' plugin
# at https://github.com/jekyll/jekyll-feed/

Jekyll::Hooks.register :site, :pre_render do |site|
  page = AnotherTestPlugin::NoFile.new(site, "", "", "test-sitemap.xml")
  site.pages << page
end

module AnotherTestPlugin
  class NoFile < Jekyll::Page
    def read_yaml(*)
      @data ||= {}
    end
  end
end
