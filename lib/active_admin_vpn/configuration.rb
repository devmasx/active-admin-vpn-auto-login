module ActiveAdminVpn
  class Configuration
    # Comma-separated CIDR ranges, e.g. "10.0.0.0/8,192.168.1.0/24"
    # Falls back to VPN_IP_RANGE env var if not set explicitly
    attr_writer :ip_ranges

    # If true, users coming from a VPN IP are automatically signed in
    # as the auto_login_email admin user — skipping the login form.
    attr_accessor :auto_login

    # AdminUser email used for auto-login when on VPN (requires auto_login: true)
    attr_accessor :auto_login_email

    # HTTP status returned to non-VPN requests (default: 403)
    attr_accessor :forbidden_status

    # Custom response body for blocked requests
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
      raise ArgumentError, "[ActiveAdminVpn] Invalid IP range in configuration: #{e.message}"
    end

    def vpn_ip?(ip)
      return false if ip.blank?
      parsed_ranges.any? { |range| range.include?(IPAddr.new(ip)) }
    rescue IPAddr::InvalidAddressError
      false
    end
  end
end
