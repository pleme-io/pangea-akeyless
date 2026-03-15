# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_dfc_key/resource'

RSpec.describe 'akeyless_dfc_key synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes DFC key' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_dfc_key(:dfc, {
          name: "/keys/dfc-key",
          alg: "AES256GCM"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_dfc_key][:dfc]

      expect(resource[:name]).to eq("/keys/dfc-key")
      expect(resource[:alg]).to eq("AES256GCM")
    end

    it 'synthesizes with custom split level' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_dfc_key(:ha, {
          name: "/keys/ha-dfc",
          alg: "RSA4096",
          split_level: 5,
          description: "High availability DFC key"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_dfc_key][:ha]

      expect(resource[:split_level]).to eq(5)
    end
  end
end
