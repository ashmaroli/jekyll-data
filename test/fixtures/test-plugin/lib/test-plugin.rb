# frozen_string_literal: true

require "jekyll"

# code abstracted from the official 'jekyll-feed' plugin
# at https://github.com/jekyll/jekyll-feed/

Jekyll::Hooks.register :site, :pre_render do |site|
  page = TestPlugin::NoFile.new(site, "", "", "test-feed.xml")
  site.pages << page
end

module TestPlugin
  class NoFile < Jekyll::Page
    def read_yaml(*)
      @data ||= {}
    end
  end
end
