# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_gateway_allowed_access/resource'

RSpec.describe 'akeyless_gateway_allowed_access synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes gateway access' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_gateway_allowed_access(:admin, {
          name: "admin-access",
          access_id: "p-1234567890",
          permissions: "admin"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_gateway_allowed_access][:admin]

      expect(resource[:name]).to eq("admin-access")
      expect(resource[:access_id]).to eq("p-1234567890")
      expect(resource[:permissions]).to eq("admin")
    end

    it 'synthesizes with sub claims' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_gateway_allowed_access(:dev, {
          name: "dev-access",
          access_id: "p-0987654321",
          sub_claims: { "groups" => "developers" },
          permissions: "defaults,targets"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_gateway_allowed_access][:dev]

      expect(resource[:permissions]).to eq("defaults,targets")
    end
  end
end
