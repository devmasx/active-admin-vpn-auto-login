# frozen_string_literal: true

RSpec.describe ActiveAdmin::VpnAutoLogin do
  it "has a version number" do
    expect(ActiveAdmin::VpnAutoLogin::VERSION).not_to be_nil
  end

  describe ".configuration" do
    it "returns a Configuration instance" do
      expect(described_class.configuration).to be_a(ActiveAdmin::VpnAutoLogin::Configuration)
    end
  end

  describe ".configure" do
    after { described_class.reset! }

    it "yields the configuration" do
      described_class.configure do |config|
        config.auto_login = true
        config.auto_login_email = "admin@example.com"
      end

      expect(described_class.configuration.auto_login).to be true
      expect(described_class.configuration.auto_login_email).to eq("admin@example.com")
    end
  end

  describe ActiveAdmin::VpnAutoLogin::Configuration do
    subject(:config) { described_class.new }

    describe "#ip_ranges" do
      it "returns empty array when not set and env var absent" do
        ENV.delete("VPN_IP_RANGE")
        expect(config.ip_ranges).to eq([])
      end

      it "reads from VPN_IP_RANGE env var" do
        ENV["VPN_IP_RANGE"] = "10.0.0.0/8"
        expect(config.ip_ranges).to eq(["10.0.0.0/8"])
        ENV.delete("VPN_IP_RANGE")
      end

      it "splits comma-separated ranges" do
        config.ip_ranges = "10.0.0.0/8,192.168.1.0/24"
        expect(config.ip_ranges).to eq(["10.0.0.0/8", "192.168.1.0/24"])
      end
    end

    describe "#vpn_ip?" do
      before { config.ip_ranges = "10.0.0.0/8" }

      it "returns true for an IP within range" do
        expect(config.vpn_ip?("10.1.2.3")).to be true
      end

      it "returns false for an IP outside range" do
        expect(config.vpn_ip?("192.168.1.1")).to be false
      end
    end
  end
end
