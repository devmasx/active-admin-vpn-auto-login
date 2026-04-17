# frozen_string_literal: true

require "active_admin/vpn_auto_login/version"
require "active_admin/vpn_auto_login/configuration"
require "active_admin/vpn_auto_login/vpn_constraint"
require "active_admin/vpn_auto_login/controller_helpers"
require "active_admin/vpn_auto_login/railtie" if defined?(Rails)

module ActiveAdmin
  module VpnAutoLogin
    class << self
      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield(configuration)
      end

      def reset!
        @configuration = Configuration.new
      end
    end
  end
end
