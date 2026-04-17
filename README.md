# ActiveAdminVpn

Restrict access to [ActiveAdmin](https://activeadmin.info/) to requests coming from
configured VPN IP ranges. Optionally auto-login VPN users so they skip the login form.

## Installation

Add to your Gemfile:

```ruby
gem "active_admin_vpn"
```

Then run:

```bash
bundle install
rails generate active_admin_vpn:install
```

This creates `config/initializers/active_admin_vpn.rb`.

---

## Configuration

### Option 1 — Environment variable (recommended)

Set `VPN_IP_RANGE` in your environment (`.env`, Heroku config vars, etc.):

```bash
VPN_IP_RANGE="10.0.0.0/8,192.168.1.0/24"
```

The gem reads this automatically — no extra code needed.

### Option 2 — Initializer

```ruby
# config/initializers/active_admin_vpn.rb
ActiveAdminVpn.configure do |config|
  config.ip_ranges = "10.0.0.0/8,192.168.1.0/24"
end
```

---

## Auto-login (skip login form on VPN)

```ruby
ActiveAdminVpn.configure do |config|
  config.ip_ranges        = ENV["VPN_IP_RANGE"]
  config.auto_login       = true
  config.auto_login_email = "admin@yourcompany.com"
end
```

When `auto_login` is `true`, any request from a VPN IP is automatically signed in
as the given `AdminUser` — no username/password required.

> **Security note:** Keep the standard login enabled for non-VPN users. Auto-login
> only applies when the request IP is inside a configured VPN range.

---

## Trusted proxies

If your app runs behind a load balancer or reverse proxy, make sure Rails trusts
the forwarded IP headers so `request.remote_ip` reflects the real client IP:

```ruby
# config/application.rb
config.action_dispatch.trusted_proxies = [
  "127.0.0.1",
  "::1",
  IPAddr.new("10.0.0.0/8"),
  IPAddr.new("172.16.0.0/12"),
  IPAddr.new("192.168.0.0/16")
]
```

---

## All configuration options

| Option             | Default     | Description                                          |
|--------------------|-------------|------------------------------------------------------|
| `ip_ranges`        | `VPN_IP_RANGE` env | Comma-separated CIDR ranges                 |
| `auto_login`       | `false`     | Skip login form for VPN users                        |
| `auto_login_email` | `nil`       | AdminUser email used for auto-login                  |
| `forbidden_status` | `:forbidden`| HTTP status for blocked requests (403)               |
| `forbidden_message`| `"Access denied..."` | Body text for blocked requests            |

---

## License

MIT
