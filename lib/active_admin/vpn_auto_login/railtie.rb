# frozen_string_literal: true

module ActiveAdmin
  module VpnAutoLogin
    class Railtie < Rails::Railtie
      initializer "active_admin_vpn_auto_login.setup" do
        ActiveSupport.on_load(:active_admin) do
          ActiveAdmin.application.on_load do
            ActiveAdmin::BaseController.include(ActiveAdmin::VpnAutoLogin::ControllerHelpers)
          end
        end
      end
    end
  end
end
