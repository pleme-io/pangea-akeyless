# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_k8s_target/resource'

RSpec.describe 'akeyless_k8s_target synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes K8s target' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_k8s_target(:cluster, {
          name: "/targets/k8s-prod",
          k8s_cluster_endpoint: "https://k8s.example.com:6443",
          k8s_cluster_ca_cert: "LS0tLS1CRUdJTi...",
          k8s_cluster_token: "eyJhbGciOiJSUzI1NiIs..."
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_k8s_target][:cluster]

      expect(resource[:name]).to eq("/targets/k8s-prod")
      expect(resource[:k8s_cluster_endpoint]).to eq("https://k8s.example.com:6443")
      expect(resource[:k8s_cluster_ca_cert]).to be_a(String)
      expect(resource[:k8s_cluster_token]).to be_a(String)
    end
  end
end
