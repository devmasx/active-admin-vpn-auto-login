module ActiveAdminVpn
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)
      desc "Creates an ActiveAdminVpn initializer in config/initializers"

      def copy_initializer
        template "initializer.rb", "config/initializers/active_admin_vpn.rb"
      end
    end
  end
end
