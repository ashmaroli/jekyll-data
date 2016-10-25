source 'https://rubygems.org'
gemspec

group :test do
  gem "rubocop", "~> 0.44.1"
  gem "cucumber", "~> 2.1"
  gem "minitest"
  gem "minitest-reporters"
  gem "minitest-profile"
  gem "shoulda"
  gem "test-theme", path: File.expand_path("test/fixtures/test-theme", File.dirname(__FILE__))
  gem "activesupport", "~> 4.2" if RUBY_VERSION < '2.2.2'
end
