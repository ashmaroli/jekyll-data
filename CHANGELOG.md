### 1.1.1 / 2021-01-24

#### Bug Fixes

  * Don't fail if the theme doesn't have a data dir. **[[`#36`][]]** by [@fauno][]
  * Fix incompatibility with Jekyll 4.2. **[[`#38`][]]** by [@fauno][]

[`#36`]: https://github.com/ashmaroli/jekyll-data/pull/36
[`#38`]: https://github.com/ashmaroli/jekyll-data/pull/38
[@fauno]: https://github.com/fauno


#### Development Improvements

  * Bump development dependencies and tested Ruby versions


#### Documentation

  * Use "successivo" as it's more widely used. **[[`#37`][]]** by [@Samplasion][]

[`#37`]: https://github.com/ashmaroli/jekyll-data/pull/37
[@Samplasion]: https://github.com/Samplasion


### 1.1.0 / 2019-09-09

#### Minor Enhancements

  * Don't abort if the site doesn't use a gem-based theme. **[[`#25`][]]**
  * Replace `File.dirname(__FILE__)` with `__dir__`. **[[`#26`][], [`e3694c8`][]]**
  * Use frozen String literals. **[[`#27`][]]**
  * Add support for Jekyll 4.0. **[[`#30`][], [`#32`][]]**
  * Add support to read TSV files **[[`1c0b048`][]]**

[`#25`]: https://github.com/ashmaroli/jekyll-data/pull/25
[`#26`]: https://github.com/ashmaroli/jekyll-data/pull/26
[`#27`]: https://github.com/ashmaroli/jekyll-data/pull/27
[`#30`]: https://github.com/ashmaroli/jekyll-data/pull/30
[`#32`]: https://github.com/ashmaroli/jekyll-data/pull/32
[`e3694c8`]: https://github.com/ashmaroli/jekyll-data/commit/e3694c8c8bc2c064f549a7ecacad65b1bf7db7e0
[`1c0b048`]: https://github.com/ashmaroli/jekyll-data/commit/1c0b048f7c1d8146b0808fee5263b7b06b1fa6de


#### Bug Fixes

  * Base theme-drop on fallback-data. **[[`#29`][]]**
  * Properly designate `Jekyll::Drops::SiteDrop#fallback_data` as a `private` method. **[[`bb0447b`][]]**
  * Memoize Jekyll::Theme#data_path. **[[`7feb5d6`][]]**

[`#29`]: https://github.com/ashmaroli/jekyll-data/pull/29
[`bb0447b`]: https://github.com/ashmaroli/jekyll-data/commit/bb0447b242c36f2277c07b45a37b053b56aa8d37
[`7feb5d6`]: https://github.com/ashmaroli/jekyll-data/commit/7feb5d6921e0bcadbed7841d7e0d76c2b141c468


#### Development Improvements

  * Update Travis configuration. **[[`#31`][]]**
  * Use `rubocop-jekyll` to enforce Jekyll's style-guide **[[`20c0550`][]]**

[`#31`]: https://github.com/ashmaroli/jekyll-data/pull/31
[`20c0550`]: https://github.com/ashmaroli/jekyll-data/commit/20c0550bcb2dacf8a202522bd576fe3aebbfb8a0


### 1.0.0 / 2017-02-15

#### Major Enhancements

  * `{{ theme.myvariable }}` now points to `site.<theme-name>.myvariable` instead of `site.data.<theme-name>.myvariable`.  **[[`#08`][]]**
  * extracting a theme-gem's config hash and incorporating it into the site's internal config hash is handled by a new  `ThemeConfiguration` class. **[[`#09`][], [`#11`][]]**
  * All new classes are now loaded under `JekyllData` module. The `Jekyll` namespace will only contain patches to the original `Jekyll` module or its classes. **[[`#15`][], [`#22`][]]**

[`#08`]: https://github.com/ashmaroli/jekyll-data/pull/8
[`#09`]: https://github.com/ashmaroli/jekyll-data/pull/9
[`#11`]: https://github.com/ashmaroli/jekyll-data/pull/11
[`#15`]: https://github.com/ashmaroli/jekyll-data/pull/15
[`#22`]: https://github.com/ashmaroli/jekyll-data/pull/22


#### Minor Enhancements

  * A new switch `--show-data` has been added to Jekyll's build-options as a supplement to existing `--verbose` switch.  **[[`#13`][], [`#18`][], [`#20`][]]**
  * Debug data output from `--show-data` is now at a fixed width and wraps nicely to the next line. **[[`#17`][], [`#19`][]]**

[`#13`]: https://github.com/ashmaroli/jekyll-data/pull/13
[`#17`]: https://github.com/ashmaroli/jekyll-data/pull/17
[`#18`]: https://github.com/ashmaroli/jekyll-data/pull/18
[`#19`]: https://github.com/ashmaroli/jekyll-data/pull/19
[`#20`]: https://github.com/ashmaroli/jekyll-data/pull/20


#### Bug Fixes

  * A theme-gem's config hash is now incorporated via the `after-reset` hook to enable Jekyll `require` the necessary plugins listed in the theme-gem's config file. **[[`#12`][]]**

[`#12`]: https://github.com/ashmaroli/jekyll-data/pull/12


#### Development Improvements

  * Improved test-suite. **[[`#14`][], [`#16`][]]**
    * Added cucumber `features` and a script for build assessment.
    * Added a couple of dummy plugins to test loading of plugins listed in a theme-gem's config file.
    * Included testing with Ruby 2.4.0.
  * Document the main gems used for testing via `gemspec`. Upgrade Bundler to v1.14.3 and above. **[[`#23`][]]**

[`#14`]: https://github.com/ashmaroli/jekyll-data/pull/14
[`#16`]: https://github.com/ashmaroli/jekyll-data/pull/16
[`#23`]: https://github.com/ashmaroli/jekyll-data/pull/23


#### Documentation

  * Update and improve documentation. **[[`#10`][]]**
  * Added this `CHANGELOG.md`. **[[`#24`][]]**

[`#10`]: https://github.com/ashmaroli/jekyll-data/pull/10
[`#24`]: https://github.com/ashmaroli/jekyll-data/pull/24


--

### 0.4.0 / 2016-12-14

#### Minor Improvements

  * Read a `_config.yml` within theme-gems, extract and merge the hash with the site's original config hash. **[[`#06`][]]**
  * Abort build process when the `theme` key has not been configured or has been commented out.

[`#06`]: https://github.com/ashmaroli/jekyll-data/pull/6


#### Documentation

  * Update README to document recent developments
  * Fix typos within comments in `.rb` file.


--

### 0.3.0 / 2016-11-21

#### Minor Improvements

  * Validate theme configuration (`_data/<theme-name>.yml`) and its override. **[[`#05`][]]**

#### Development Improvements

  * Add Continuous Integration with Travis CI. **[[`#03`][]]**
  * Add and update files to run Minitest. **[[`#04`][]]**

[`#03`]: https://github.com/ashmaroli/jekyll-data/pull/3
[`#04`]: https://github.com/ashmaroli/jekyll-data/pull/4
[`#05`]: https://github.com/ashmaroli/jekyll-data/pull/5


--

### 0.2.1 / 2016-10-21

  * Alter methods for debugging. **[[`#02`][]]**
  * Clarify plugin's actions in README.

[`#02`]: https://github.com/ashmaroli/jekyll-data/pull/2


--

### 0.2.0 / 2016-10-18

  * Flesh out README with proper installation & usage instructions.
  * Refactor private debugging methods. **[[`#01`][]]**
  * Add Gem-Version badge to README.

[`#01`]: https://github.com/ashmaroli/jekyll-data/pull/1


--

### Initial Release / 2016-10-16 [YANKED]
