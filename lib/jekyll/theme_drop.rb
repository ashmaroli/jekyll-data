# frozen_string_literal: true

module Jekyll
  module Drops
    class UnifiedPayloadDrop < Drop
      # Register a namespace to easily call subkeys under <theme-name> key
      # in the _config.yml within a theme-gem via its bundled templates.
      #   e.g. with this drop, theme-specific variables usually called like
      #        {{ site.minima.date_format }} can be shortened to simply
      #        {{ theme.date_format }}.
      def theme
        @theme_drop ||= site.fallback_data[site.fallback_data["theme"]]
      end
    end
  end
end
