module Jekyll
  class Command
    #
    # patch original method to inject a --data switch to display merged data hash
    def self.add_build_options(c)
      c.option "config", "--config CONFIG_FILE[,CONFIG_FILE2,...]",
        Array, "Custom configuration file"
      c.option "destination", "-d", "--destination DESTINATION",
        "The current folder will be generated into DESTINATION"
      c.option "source", "-s", "--source SOURCE", "Custom source directory"
      c.option "future", "--future", "Publishes posts with a future date"
      c.option "limit_posts", "--limit_posts MAX_POSTS", Integer,
        "Limits the number of posts to parse and publish"
      c.option "watch", "-w", "--[no-]watch", "Watch for changes and rebuild"
      c.option "baseurl", "-b", "--baseurl URL",
        "Serve the website from the given base URL"
      c.option "force_polling", "--force_polling", "Force watch to use polling"
      c.option "lsi", "--lsi", "Use LSI for improved related posts"
      c.option "show_drafts", "-D", "--drafts", "Render posts in the _drafts folder"
      c.option "unpublished", "--unpublished",
        "Render posts that were marked as unpublished"
      c.option "quiet", "-q", "--quiet", "Silence output."
      c.option "verbose", "-V", "--verbose", "Print verbose output."
      c.option "data", "--data", "Print verbose data output when used with --verbose."
      c.option "incremental", "-I", "--incremental", "Enable incremental rebuild."
    end
  end
end
