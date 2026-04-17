require "active_admin_vpn/version"
require "active_admin_vpn/configuration"
require "active_admin_vpn/vpn_constraint"
require "active_admin_vpn/controller_helpers"
require "active_admin_vpn/railtie" if defined?(Rails)

module ActiveAdminVpn
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
