module ActiveAdminVpn
  class Railtie < Rails::Railtie
    initializer "active_admin_vpn.setup" do
      ActiveSupport.on_load(:active_admin) do
        # Hook into ActiveAdmin after it initializes
        ActiveAdmin.application.on_load do
          ActiveAdmin::BaseController.include(ActiveAdminVpn::ControllerHelpers)
        end
      end
    end
  end
end
