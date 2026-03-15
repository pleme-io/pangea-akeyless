# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_associate_role_auth_method/resource'

RSpec.describe 'akeyless_associate_role_auth_method synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes basic association' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_associate_role_auth_method(:admin_api_key, {
          role_name: "/admin-role",
          am_name: "/api-key-auth"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_associate_role_auth_method][:admin_api_key]

      expect(resource[:role_name]).to eq("/admin-role")
      expect(resource[:am_name]).to eq("/api-key-auth")
    end

    it 'synthesizes with sub claims' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_associate_role_auth_method(:scoped, {
          role_name: "/reader-role",
          am_name: "/oidc-auth",
          sub_claims: { "groups" => "engineering" },
          case_sensitive: "false"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_associate_role_auth_method][:scoped]

      expect(resource[:role_name]).to eq("/reader-role")
      expect(resource[:case_sensitive]).to eq("false")
    end
  end
end
