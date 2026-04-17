module ActiveAdminVpn
  module ControllerHelpers
    extend ActiveSupport::Concern

    included do
      before_action :enforce_vpn_access
      before_action :auto_login_from_vpn, if: -> { ActiveAdminVpn.configuration.auto_login }
    end

    private

    def on_vpn?
      ActiveAdminVpn.configuration.vpn_ip?(request.remote_ip)
    end

    def enforce_vpn_access
      return if on_vpn?

      config = ActiveAdminVpn.configuration
      render plain: config.forbidden_message, status: config.forbidden_status
    end

    def auto_login_from_vpn
      return unless on_vpn?
      return if respond_to?(:current_admin_user) && current_admin_user

      email = ActiveAdminVpn.configuration.auto_login_email
      if email.blank?
        Rails.logger.warn "[ActiveAdminVpn] auto_login is enabled but auto_login_email is not set."
        return
      end

      user = AdminUser.find_by(email: email)
      if user
        sign_in(user)
      else
        Rails.logger.warn "[ActiveAdminVpn] auto_login_email '#{email}' not found in AdminUser."
      end
    end
  end
end
