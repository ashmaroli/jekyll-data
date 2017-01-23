Feature: Configuring Gem-based Themes
  As a hacker who likes to share my expertise
  I want to be able to configure my gemified theme
  In order to make it easier for other Jekyllites to use my theme

  Scenario: A site not using a gem-based theme
    Given I have a configuration file with:
      | key           | value                           |
      | exclude       | [Gemfile, Gemfile.lock]         |
    And I have a Gemfile with plugin:
      | name          | path                            |
      | test-plugin   | ../../test/fixtures/test-plugin |
    When I run bundle exec jekyll build
    Then I should get a non-zero exit status
    And I should see "JekyllData: Error!" in the build output
    And the _site directory should not exist
    And the "_site/feed.xml" file should not exist

  Scenario: Theme-gem has a config file with valid 'gems' array
    Given I have a configuration file with:
      | key           | value                           |
      | theme         | test-theme                      |
      | exclude       | [Gemfile, Gemfile.lock]         |
    And I have a Gemfile with plugin:
      | name          | path                            |
      | test-plugin   | ../../test/fixtures/test-plugin |
    When I run bundle exec jekyll build
    Then I should get a zero exit status
    And the _site directory should exist
    And the "_site/feed.xml" file should exist

  Scenario: Overriding the 'gems' array in a config file within theme-gem
    Given I have a configuration file with:
      | key           | value                              |
      | theme         | test-theme                         |
      | gems          | [jekyll-data, another-test-plugin] |
      | exclude       | [Gemfile, Gemfile.lock]            |
    And I have a Gemfile with plugin:
      | name                | path                                    |
      | another-test-plugin | ../../test/fixtures/another-test-plugin |
    When I run bundle exec jekyll build
    Then I should get a zero exit status
    And the _site directory should exist
    And the "_site/sitemap.xml" file should exist
    And the "_site/feed.xml" file should not exist

  Scenario: Theme-gem has a config file with valid '<theme-name>' object
    Given I have a configuration file with:
      | key           | value                           |
      | theme         | test-theme                      |
      | gems          | [jekyll-data]                   |
      | exclude       | [Gemfile, Gemfile.lock]         |
    And I have a valid Gemfile
    And I have a "page.md" file with content:
      """
      ---
      ---
      theme-logo : ![theme-logo]({{ theme.logo }})
      theme-variant : {{ theme.theme_variant }}

      """
    When I run bundle exec jekyll build
    Then I should get a zero exit status
    And the _site directory should exist
    And I should see "theme-logo : <img src="logo.png" alt="theme-logo" />" in "_site/page.html"
    And I should see "theme-variant : Charcoal" in "_site/page.html"
