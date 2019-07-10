# frozen_string_literal: true

source "https://rubygems.org"
gemspec

gem "jekyll", ENV["JEKYLL_VERSION"] if ENV["JEKYLL_VERSION"]

group :test do
  gem "activesupport", "~> 4.2" if RUBY_VERSION < "2.2.2"
  gem "another-test-plugin", :path => File.expand_path("test/fixtures/another-test-plugin", __dir__)
  gem "minitest-profile"
  gem "minitest-reporters"
  gem "rspec"
  gem "rspec-mocks"
  gem "shoulda"
  gem "test-plugin", :path => File.expand_path("test/fixtures/test-plugin", __dir__)
  gem "test-theme", :path => File.expand_path("test/fixtures/test-theme", __dir__)
end
