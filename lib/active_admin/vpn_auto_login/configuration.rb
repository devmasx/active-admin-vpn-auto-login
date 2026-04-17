# frozen_string_literal: true

module ActiveAdmin
  module VpnAutoLogin
    class Configuration
      attr_writer :ip_ranges
      attr_accessor :auto_login
      attr_accessor :auto_login_email
      attr_accessor :forbidden_status
      attr_accessor :forbidden_message

      def initialize
        @auto_login       = false
        @auto_login_email = nil
        @forbidden_status = :forbidden
        @forbidden_message = "Access denied. Connect to the VPN to access this area."
      end

      def ip_ranges
        raw = @ip_ranges || ENV["VPN_IP_RANGE"] || ""
        raw.split(",").map(&:strip).reject(&:empty?)
      end

      def parsed_ranges
        ip_ranges.map { |cidr| IPAddr.new(cidr) }
      rescue IPAddr::InvalidAddressError => e
        raise ArgumentError, "[ActiveAdmin::VpnAutoLogin] Invalid IP range in configuration: #{e.message}"
      end

      def vpn_ip?(ip)
        return false if ip.blank?
        parsed_ranges.any? { |range| range.include?(IPAddr.new(ip)) }
      rescue IPAddr::InvalidAddressError
        false
      end
    end
  end
end
