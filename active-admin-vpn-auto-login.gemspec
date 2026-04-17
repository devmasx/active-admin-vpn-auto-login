# frozen_string_literal: true

require_relative "lib/active_admin/vpn_auto_login/version"

Gem::Specification.new do |spec|
  spec.name = "active-admin-vpn-auto-login"
  spec.version = ActiveAdmin::VpnAutoLogin::VERSION
  spec.authors = ["Your Name"]
  spec.email = ["your.email@example.com"]

  spec.summary = "A Rails gem that limits access to ActiveAdmin to requests coming from configured VPN IP ranges (CIDR). Supports optional auto-login for VPN users so they skip the login form entirely."
  spec.description = "A Rails gem that limits access to ActiveAdmin to requests coming from configured VPN IP ranges (CIDR). Supports optional auto-login for VPN users so they skip the login form entirely."
  spec.homepage = "https://github.com/yourusername/active-admin-vpn-auto-login"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end

  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 6.0"
  spec.add_dependency "activeadmin", ">= 2.0"
end
