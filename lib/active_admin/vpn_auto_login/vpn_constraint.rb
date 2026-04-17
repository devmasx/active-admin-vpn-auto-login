# frozen_string_literal: true

module ActiveAdmin
  module VpnAutoLogin
    class VpnConstraint
      def self.matches?(request)
        ActiveAdmin::VpnAutoLogin.configuration.vpn_ip?(request.remote_ip)
      end
    end
  end
end
