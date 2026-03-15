# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_certificate/resource'

RSpec.describe 'akeyless_certificate synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes certificate upload' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_certificate(:tls, {
          name: "/certs/tls-cert",
          certificate_data: "-----BEGIN CERTIFICATE-----\nMIIB...",
          format: "pem",
          key_data: "-----BEGIN PRIVATE KEY-----\nMIIE..."
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_certificate][:tls]

      expect(resource[:name]).to eq("/certs/tls-cert")
      expect(resource[:certificate_data]).to be_a(String)
    end

    it 'synthesizes with tags' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_certificate(:wildcard, {
          name: "/certs/wildcard",
          certificate_data: "cert-data",
          tags: ["production", "wildcard"],
          description: "Wildcard certificate"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_certificate][:wildcard]

      expect(resource[:tags]).to eq(["production", "wildcard"])
      expect(resource[:description]).to eq("Wildcard certificate")
    end
  end
end
