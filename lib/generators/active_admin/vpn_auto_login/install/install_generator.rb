# frozen_string_literal: true

module ActiveAdmin
  module VpnAutoLogin
    module Generators
      class InstallGenerator < Rails::Generators::Base
        source_root File.expand_path("templates", __dir__)
        desc "Creates an ActiveAdmin::VpnAutoLogin initializer in config/initializers"

        def copy_initializer
          template "initializer.rb", "config/initializers/active_admin_vpn_auto_login.rb"
        end
      end
    end
  end
end
