# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_auth_method_oauth2/resource'

RSpec.describe 'akeyless_auth_method_oauth2 synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes OAuth2 auth method' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_auth_method_oauth2(:github, {
          name: "/github-oauth",
          unique_identifier: "email",
          jwks_uri: "https://token.actions.githubusercontent.com/.well-known/jwks",
          issuer: "https://token.actions.githubusercontent.com"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_auth_method_oauth2][:github]

      expect(resource[:name]).to eq("/github-oauth")
      expect(resource[:unique_identifier]).to eq("email")
      expect(resource[:jwks_uri]).to eq("https://token.actions.githubusercontent.com/.well-known/jwks")
      expect(resource[:issuer]).to eq("https://token.actions.githubusercontent.com")
    end

    it 'synthesizes with bound client IDs' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_auth_method_oauth2(:restricted, {
          name: "/restricted-oauth",
          unique_identifier: "sub",
          bound_client_ids: ["client-1", "client-2"],
          audience: "https://api.example.com"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_auth_method_oauth2][:restricted]

      expect(resource[:bound_client_ids]).to eq(["client-1", "client-2"])
      expect(resource[:audience]).to eq("https://api.example.com")
    end
  end
end
