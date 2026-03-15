# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_pki_cert_issuer/resource'

RSpec.describe 'akeyless_pki_cert_issuer synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes PKI cert issuer' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_pki_cert_issuer(:internal, {
          name: "/pki/internal-issuer",
          signer_key_name: "/keys/rsa-ca",
          ttl: "8760h",
          allowed_domains: "*.internal.pleme.io,internal.pleme.io",
          allow_subdomains: true
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_pki_cert_issuer][:internal]

      expect(resource[:name]).to eq("/pki/internal-issuer")
      expect(resource[:signer_key_name]).to eq("/keys/rsa-ca")
      expect(resource[:ttl]).to eq("8760h")
      expect(resource[:allowed_domains]).to eq("*.internal.pleme.io,internal.pleme.io")
      expect(resource[:allow_subdomains]).to be true
    end

    it 'synthesizes CA cert issuer' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_pki_cert_issuer(:ca, {
          name: "/pki/ca",
          signer_key_name: "/keys/root-ca",
          ttl: "87600h",
          is_ca: true,
          allow_any_name: true,
          country: "US",
          organizations: "Pleme Inc"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_pki_cert_issuer][:ca]

      expect(resource[:is_ca]).to be true
      expect(resource[:allow_any_name]).to be true
      expect(resource[:country]).to eq("US")
    end
  end
end
