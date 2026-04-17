ActiveAdmin::VpnAutoLogin.configure do |config|
  # ------------------------------------------------------------
  # VPN IP ranges (CIDR notation, comma-separated)
  # ------------------------------------------------------------
  # You can set them directly here:
  #   config.ip_ranges = "10.0.0.0/8,192.168.1.0/24"
  #
  # Or leave it blank and set the environment variable instead:
  #   VPN_IP_RANGE="10.0.0.0/8,192.168.1.0/24"
  #
  # config.ip_ranges = ENV["VPN_IP_RANGE"]

  # ------------------------------------------------------------
  # Auto-login (optional)
  # ------------------------------------------------------------
  # When true, users whose request.remote_ip matches a VPN range
  # are automatically signed in — no login form required.
  #
  # config.auto_login       = true
  # config.auto_login_email = "admin@yourcompany.com"

  # ------------------------------------------------------------
  # Blocked request response
  # ------------------------------------------------------------
  # HTTP status returned to non-VPN requests (default: :forbidden / 403)
  # config.forbidden_status  = :forbidden

  # Body of the response shown to blocked visitors
  # config.forbidden_message = "Access denied. Connect to the VPN to access this area."
end
