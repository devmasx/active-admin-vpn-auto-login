require_relative "lib/active_admin_vpn/version"

Gem::Specification.new do |spec|
  spec.name          = "active_admin_vpn"
  spec.version       = ActiveAdminVpn::VERSION
  spec.authors       = ["Your Name"]
  spec.email         = ["you@example.com"]

  spec.summary       = "Restrict ActiveAdmin access to VPN IP ranges"
  spec.description   = <<~DESC
    A Rails gem that limits access to ActiveAdmin to requests coming from
    configured VPN IP ranges (CIDR). Supports optional auto-login for VPN
    users so they skip the login form entirely.
  DESC
  spec.homepage      = "https://github.com/yourname/active_admin_vpn"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 2.7.0"

  spec.files = Dir[
    "lib/**/*",
    "README.md",
    "LICENSE.txt",
    "active_admin_vpn.gemspec"
  ]

  spec.require_paths = ["lib"]

  spec.add_dependency "rails",        ">= 6.0"
  spec.add_dependency "activeadmin",  ">= 2.0"

  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "devise"
end
