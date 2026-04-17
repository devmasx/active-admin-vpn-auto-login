module ActiveAdminVpn
  # Use this as a route constraint to restrict access at the routing level.
  #
  # Example in config/routes.rb:
  #
  #   constraints(ActiveAdminVpn::VpnConstraint) do
  #     ActiveAdmin.routes(self)
  #   end
  #
  class VpnConstraint
    def self.matches?(request)
      ActiveAdminVpn.configuration.vpn_ip?(request.remote_ip)
    end
  end
end
