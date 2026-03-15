# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_ssh_cert_issuer/resource'

RSpec.describe 'akeyless_ssh_cert_issuer synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes SSH cert issuer' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_ssh_cert_issuer(:bastion, {
          name: "/ssh/bastion-issuer",
          signer_key_name: "/keys/ssh-ca",
          allowed_users: "ubuntu,admin",
          ttl: 3600
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_ssh_cert_issuer][:bastion]

      expect(resource[:name]).to eq("/ssh/bastion-issuer")
      expect(resource[:signer_key_name]).to eq("/keys/ssh-ca")
      expect(resource[:allowed_users]).to eq("ubuntu,admin")
      expect(resource[:ttl]).to eq(3600)
    end
  end
end
