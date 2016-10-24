# JekyllData

[![Gem Version](https://img.shields.io/gem/v/jekyll-data.svg)](https://rubygems.org/gems/jekyll-data)
[![Build Status](https://img.shields.io/travis/ashmaroli/jekyll-data/master.svg?label=Build%20Status)][travis]

[travis]: https://travis-ci.org/ashmaroli/jekyll-data

Introducing a plugin that reads data files within **jekyll theme gems** and adds the resulting hash to the site's internal data hash.

## Installation

Simply add the plugin to your site's Gemfile and config file like every other jekyll plugin gems..
```ruby
# Gemfile

group :jekyll_plugins do
  gem "jekyll-data"
end
``` 
```yaml
# _config.yml

gems:
  - jekyll-data

```
..and run 
```
bundle install
```

## Usage

As long as the gem has been installed properly, and is included in the Gemfile & the config file, data-files supported by Jekyll and present in the `_data` directory at the root of your theme gem will be read. Their contents will be added to the site's internal data hash, provided, an identical data hash doesn't already exist at the site-source.

### Theme Configuration

Jekyll themes (built prior to Jekyll 3.2) usually ship with configuration settings defined in the config file, which are then used within the theme's template files directly under the `site` namespace (e.g. `{{ site.myvariable }}`). This is not possible with theme gems as data-files within gems are not natively read (as of Jekyll 3.3), and hence require end-users to inspect a *demo* or *example* directory to source those files.  
This plugin provides a way to have the said data-files read and be used by the site. This plugin expects to find all data-files within the `_data` directory at the root of the theme gem.

Theme specific directives *should* be defined in a file named the same as `theme.name`.  
e.g. if *minima* were to ship a YAML file with such directives, then it would've a **_data/minima.yml** and variables within it would be referenced in the template files using a `theme` namespace like so: `{{ theme.myvariable }}` (which is functionally identical to `{{ site.data.minima.myvariable }}`)

### Regular Data-files

Regular data files that may be used to supplement theme templates (e.g. demo placeholders) can be named as desired. Either use a sub-directory to house related data-files or declare all of them as a mapped data block within a single file.
```yaml
# <theme-gem>/_data/apparel.yml

shirts:
  - color: white
    size: large
    image: s_w_lg.jpg
  - color: black
    size: large
    image: s_b_lg.jpg

jeans:
  - color: khaki
    waist: 34
    image: j_kh_34.jpg
  - color: blue
    waist: 32
    image: j_bu_32.jpg
```
is the same as:
```yaml
# <theme-gem>/_data/apparel/shirts.yml

- color: white
  size: large
  image: s_w_lg.jpg
- color: black
  size: large
  image: s_b_lg.jpg
```
```yaml
# <theme-gem>/_data/apparel/jeans.yml

- color: khaki
  waist: 34
  image: j_kh_34.jpg
- color: blue
  waist: 32
  image: j_bu_32.jpg
```

### User-overrides

To override directives shipped with a theme gem, simply have an identical hash at the site-source.  
e.g.
```yaml
# <site_source_dir>/_data/navigation.yml

mainmenu:
  - title: Home
    url: /
  - title: Kitchen Diaries
    url: /kitchen-diaries/
  - title: Tips & Tricks
    url: /tips-n-tricks/
  - title: Health Facts
    url: /health/
  - title: About Me
    url: /about/ 
 ```
 would have overridden the following:
 ```yaml
# <theme-gem>/_data/navigation/mainmenu.yml

- title: Link Item 1
  url: /link-one/
- title: Link Item 2
  url: /link-two/
- title: Link Item 3
  url: /link-three/
```

## Contributing

Bug reports and pull requests are welcome at the [GitHub Repo](https://github.com/ashmaroli/jekyll-data). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

