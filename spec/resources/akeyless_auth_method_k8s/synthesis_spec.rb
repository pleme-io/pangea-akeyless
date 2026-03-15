# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_auth_method_k8s/resource'

RSpec.describe 'akeyless_auth_method_k8s synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes K8s auth method' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_auth_method_k8s(:cluster, {
          name: "/k8s-auth",
          bound_namespaces: ["default", "production"],
          bound_sa_names: ["my-service-account"]
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_auth_method_k8s][:cluster]

      expect(resource[:name]).to eq("/k8s-auth")
      expect(resource[:bound_namespaces]).to eq(["default", "production"])
      expect(resource[:bound_sa_names]).to eq(["my-service-account"])
    end
  end

  describe 'resource references' do
    it 'provides private_key output' do
      ref = synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_auth_method_k8s(:test, { name: "/test" })
      end

      expect(ref.outputs[:private_key]).to eq('${akeyless_auth_method_k8s.test.private_key}')
    end
  end
end
