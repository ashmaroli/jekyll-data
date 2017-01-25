Feature: Reading Data files in Gem-based Themes
  As a hacker who likes to share my expertise
  I want to be able to include data files in my gemified theme
  In order to supplement the templates with default text-strings

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
    And the "_site/test-feed.xml" file should not exist

  Scenario: Theme-gem has a data file to support i18n
    Given I have a configuration file with:
      | key           | value                           |
      | lang          | fr                              |
      | theme         | test-theme                      |
      | gems          | [jekyll-data]                   |
      | exclude       | [Gemfile, Gemfile.lock]         |
    And I have a "locales.md" file with content:
      """
      ---
      ---

      {% assign ui = site.data.locales[site.lang] %}
      {% assign user = "John Smith" %}

      {{ ui.greeting }} {{ user }}

      {{ ui.prev }}

      {{ ui.next }}
      """
    And I have a valid Gemfile
    When I run bundle exec jekyll build
    Then I should get a zero exit status
    And the _site directory should exist
    And I should see "Bonjour, Bienvenue! John Smith" in "_site/locales.html"
    And I should see "précédent" in "_site/locales.html"
    And I should see "prochain" in "_site/locales.html"

  Scenario: Overriding a data file within theme-gem - Method I
    Given I have a configuration file with:
      | key           | value                           |
      | lang          | fr                              |
      | theme         | test-theme                      |
      | gems          | [jekyll-data]                   |
      | exclude       | [Gemfile, Gemfile.lock]         |
    And I have a "locales.md" file with content:
      """
      ---
      ---

      {% assign ui = site.data.locales[site.lang] %}
      {% assign user = "John Smith" %}

      {{ ui.greeting }} {{ user }}!

      {{ ui.prev }}

      {{ ui.next }}
      """
    And I have a _data directory
    And I have a "_data/locales.yml" file with content:
      """
      fr:
        greeting: "Bonjour! Bienvenue"
      """
    And I have a valid Gemfile
    When I run bundle exec jekyll build
    Then I should get a zero exit status
    And the _site directory should exist
    And I should see "Bonjour! Bienvenue John Smith!" in "_site/locales.html"
    And I should see "précédent" in "_site/locales.html"
    And I should see "prochain" in "_site/locales.html"

  Scenario: Overriding a data file within theme-gem - Method II
    Given I have a configuration file with:
      | key           | value                           |
      | lang          | fr                              |
      | theme         | test-theme                      |
      | gems          | [jekyll-data]                   |
      | exclude       | [Gemfile, Gemfile.lock]         |
    And I have a "locales.md" file with content:
      """
      ---
      ---

      {% assign ui = site.data.locales[site.lang] %}
      {% assign user = "John Smith" %}

      {{ ui.greeting }} {{ user }}!

      {{ ui.prev }}

      {{ ui.next }}
      """
    And I have a _data/locales directory
    And I have a "_data/locales/fr.yml" file with content:
      """
      greeting: "Bonjour! Bienvenue"
      """
    And I have a valid Gemfile
    When I run bundle exec jekyll build
    Then I should get a zero exit status
    And the _site directory should exist
    And I should see "Bonjour! Bienvenue John Smith!" in "_site/locales.html"
    And I should see "précédent" in "_site/locales.html"
    And I should see "prochain" in "_site/locales.html"
