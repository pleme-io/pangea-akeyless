# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_classic_key/resource'

RSpec.describe 'akeyless_classic_key synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes AES key' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_classic_key(:encryption, {
          name: "/keys/aes-key",
          alg: "AES256GCM"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_classic_key][:encryption]

      expect(resource[:name]).to eq("/keys/aes-key")
      expect(resource[:alg]).to eq("AES256GCM")
    end

    it 'synthesizes RSA key with certificate' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_classic_key(:signing, {
          name: "/keys/rsa-key",
          alg: "RSA2048",
          description: "Signing key",
          generate_self_signed_certificate: true,
          certificate_ttl: 365,
          certificate_common_name: "pleme.io",
          tags: ["signing", "production"]
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_classic_key][:signing]

      expect(resource[:alg]).to eq("RSA2048")
      expect(resource[:generate_self_signed_certificate]).to be true
      expect(resource[:certificate_ttl]).to eq(365)
      expect(resource[:tags]).to eq(["signing", "production"])
    end
  end
end
