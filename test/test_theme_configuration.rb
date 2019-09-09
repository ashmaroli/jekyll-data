# frozen_string_literal: true

require "helper"

class TestThemeConfiguration < JekyllDataTest
  context "site without data files but with a configured theme" do
    setup do
      @site = fixture_site(
        "source"      => File.join(source_dir, "no_data_config"),
        "destination" => File.join(dest_dir, "no_data_config")
      )
      assert @site.theme
      @theme_data = ThemeDataReader.new(@site).read("_data")
      @site.process
    end

    should "read and use data under the 'theme' namespace" do
      assert_equal(
        File.read(File.join(fixture_dir, "no_data_config_output.html")),
        File.read(@site.in_dest_dir("output.html"))
      )
    end
  end

  context "site with theme configuration overrides" do
    setup do
      @site = fixture_site(
        "source"      => File.join(source_dir, "empty_config_override"),
        "destination" => File.join(dest_dir, "empty_config_override")
      )
    end

    should "alert if the override file is empty" do
      reader = double(@site)
      msg = "Cannot define or override Theme Configuration with an empty file!"
      expect(reader).to receive(:process).with(no_args).and_return(msg)
      assert_equal msg, reader.process
    end
  end

  context "site with theme configuration overrides" do
    setup do
      @site = fixture_site(
        "source"      => File.join(source_dir, "not_hash_config_override"),
        "destination" => File.join(dest_dir, "not_hash_config_override")
      )
    end

    should "alert if the override is not a Hash Object" do
      reader = double(@site)
      msg = "Theme Config or its override should be a Hash of key:value pairs " \
            "or mappings. But got Array instead."
      expect(reader).to receive(:process).with(no_args).and_return(msg)
      assert_equal msg, reader.process
    end
  end
end
