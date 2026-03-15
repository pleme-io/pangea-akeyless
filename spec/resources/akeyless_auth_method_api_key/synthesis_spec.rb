# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_auth_method_api_key/resource'

RSpec.describe 'akeyless_auth_method_api_key synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes basic API key auth method' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_auth_method_api_key(:ci, {
          name: "/ci-auth"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_auth_method_api_key][:ci]

      expect(resource[:name]).to eq("/ci-auth")
    end

    it 'synthesizes with all options' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_auth_method_api_key(:full, {
          name: "/full-api-key",
          access_expires: 7200,
          bound_ips: ["192.168.1.0/24"],
          force_sub_claims: true,
          jwt_ttl: 600,
          delete_protection: "true"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_auth_method_api_key][:full]

      expect(resource[:name]).to eq("/full-api-key")
      expect(resource[:access_expires]).to eq(7200)
      expect(resource[:bound_ips]).to eq(["192.168.1.0/24"])
      expect(resource[:force_sub_claims]).to be true
      expect(resource[:jwt_ttl]).to eq(600)
      expect(resource[:delete_protection]).to eq("true")
    end
  end

  describe 'resource references' do
    it 'provides access_id and access_key outputs' do
      ref = synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_auth_method_api_key(:test, { name: "/test" })
      end

      expect(ref.id).to eq('${akeyless_auth_method_api_key.test.id}')
      expect(ref.outputs[:access_id]).to eq('${akeyless_auth_method_api_key.test.access_id}')
      expect(ref.outputs[:access_key]).to eq('${akeyless_auth_method_api_key.test.access_key}')
    end
  end
end
