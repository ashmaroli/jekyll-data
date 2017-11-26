# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name     = "another-test-plugin"
  s.version  = "0.1.0"
  s.licenses = ["MIT"]
  s.summary  = "A plugin that creates an empty 'sitemap.xml' to test JekyllData Plugin"
  s.authors  = ["JekyllData"]
  s.require_paths = ["lib"]
end
