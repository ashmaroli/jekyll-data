# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jekyll-data/version"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-data"
  spec.version       = JekyllData::VERSION
  spec.authors       = ["Ashwin Maroli"]
  spec.email         = ["ashmaroli@gmail.com"]

  spec.summary       = "A plugin to read '_config.yml' and data files within Jekyll theme-gems"
  spec.homepage      = "https://github.com/ashmaroli/jekyll-data"
  spec.license       = "MIT"

  spec.metadata      = { "allowed_push_host" => "https://rubygems.org" }

  spec.files         = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r!^(lib/|(LICENSE|README)((\.(txt|md|markdown)|$)))!i)
  end
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "jekyll", ">= 3.3", "< 5.0.0"

  spec.add_development_dependency "bundler", ">= 1.14.3"
  spec.add_development_dependency "cucumber", "~> 2.1"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rubocop", "~> 0.51.0"
end
