# frozen_string_literal: true

require "helper"

class TestThemeReader < JekyllDataTest
  context "site without data files but with a valid theme" do
    setup do
      @site = fixture_site(
        "source"      => File.join(source_dir, "no_data_files"),
        "destination" => File.join(dest_dir, "no_data_files")
      )
      assert @site.theme
      @theme_data = ThemeDataReader.new(@site).read("_data")
      @site.process
    end
    should "read data files in theme gem" do
      assert_equal @site.data["navigation"]["topnav"],
                   @theme_data["navigation"]["topnav"]
    end

    should "use data from theme gem" do
      assert_equal File.read(@site.in_dest_dir("output.html")),
        File.read(File.join(fixture_dir, "no_data_output.html"))
    end
  end

  context "site with data keys different from a valid theme data hash" do
    setup do
      @site = fixture_site(
        "source"      => File.join(source_dir, "diff_data_keys"),
        "destination" => File.join(dest_dir, "diff_data_keys")
      )
      assert @site.theme
      @theme_data = ThemeDataReader.new(@site).read("_data")
      @site.process
    end
    should "read and use data from other keys in theme gem" do
      assert_equal File.read(@site.in_dest_dir("output.html")),
        File.read(File.join(fixture_dir, "different_data_output.html"))
    end

    should "not override theme data" do
      assert_equal File.read(@site.in_dest_dir("output.html")),
        File.read(File.join(fixture_dir, "different_data_output.html"))
    end
  end

  context "site with same data keys as a valid theme data hash" do
    setup do
      @site = fixture_site(
        "source"      => File.join(source_dir, "same_data_files"),
        "destination" => File.join(dest_dir, "same_data_files")
      )
      assert @site.theme
      @theme_data = ThemeDataReader.new(@site).read("_data")
      @site.process
    end
    should "override theme data" do
      assert_equal File.read(@site.in_dest_dir("override.html")),
        File.read(File.join(fixture_dir, "same_data_override.html"))
    end

    should "also use data from other keys in theme gem" do
      assert_equal File.read(@site.in_dest_dir("override.html")),
        File.read(File.join(fixture_dir, "same_data_output.html"))
    end
  end

  context "theme gem shipped with a '_config.yml'" do
    setup do
      @site = fixture_site(
        "title" => "Config Test"
      )
    end

    should "have its hash appended to site's config hash" do
      assert_contains @site.config, %w(post_excerpts enabled)
    end

    should "have its hash added only where its not already set" do
      refute_equal "Test Theme", @site.config["title"]
      assert_equal "Config Test", @site.config["title"]
    end
  end
end
