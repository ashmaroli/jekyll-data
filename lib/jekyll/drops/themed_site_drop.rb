# encoding: UTF-8

module Jekyll
  module Drops
    class ThemedSiteDrop < SiteDrop
      extend Forwardable

      mutable false

      def_delegator  :@obj, :site_data, :data
      def_delegators :@obj, :theme

      private
      def_delegator :@obj, :config, :fallback_data
    end
  end
end
