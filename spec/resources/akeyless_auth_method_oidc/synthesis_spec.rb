# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_auth_method_oidc/resource'

RSpec.describe 'akeyless_auth_method_oidc synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes OIDC auth method' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_auth_method_oidc(:okta, {
          name: "/okta-oidc",
          unique_identifier: "email",
          issuer: "https://dev-12345.okta.com",
          client_id: "0oa1234567890",
          client_secret: "secret123",
          allowed_redirect_uri: ["https://console.akeyless.io/login-callback"]
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_auth_method_oidc][:okta]

      expect(resource[:name]).to eq("/okta-oidc")
      expect(resource[:unique_identifier]).to eq("email")
      expect(resource[:issuer]).to eq("https://dev-12345.okta.com")
      expect(resource[:client_id]).to eq("0oa1234567890")
      expect(resource[:allowed_redirect_uri]).to include("https://console.akeyless.io/login-callback")
    end
  end
end
