# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_auth_method/resource'

RSpec.describe 'akeyless_auth_method synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes basic auth method' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_auth_method(:test, {
          name: "/my-auth-method"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_auth_method][:test]

      expect(resource[:name]).to eq("/my-auth-method")
    end

    it 'synthesizes auth method with bound IPs' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_auth_method(:restricted, {
          name: "/restricted-auth",
          bound_ips: ["10.0.0.0/8", "172.16.0.0/12"],
          access_expires: 3600,
          force_sub_claims: true
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_auth_method][:restricted]

      expect(resource[:name]).to eq("/restricted-auth")
      expect(resource[:bound_ips]).to eq(["10.0.0.0/8", "172.16.0.0/12"])
      expect(resource[:access_expires]).to eq(3600)
      expect(resource[:force_sub_claims]).to be true
    end
  end

  describe 'resource references' do
    it 'provides correct terraform interpolation strings' do
      ref = synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_auth_method(:test, { name: "/test" })
      end

      expect(ref.id).to eq('${akeyless_auth_method.test.id}')
      expect(ref.outputs[:access_id]).to eq('${akeyless_auth_method.test.access_id}')
    end
  end
end
