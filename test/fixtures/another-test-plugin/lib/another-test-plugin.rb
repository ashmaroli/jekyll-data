require "jekyll"

Jekyll::Hooks.register :site, :after_init do |site|
  file = File.expand_path("sitemap.xml", site.config["source"])
  File.open(file, "w")
  File.write(file, "---\n---\n")
end
