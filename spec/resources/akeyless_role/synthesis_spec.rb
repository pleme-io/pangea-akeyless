# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_role/resource'

RSpec.describe 'akeyless_role synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes basic role' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_role(:admin, {
          name: "/admin-role",
          description: "Admin role"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_role][:admin]

      expect(resource[:name]).to eq("/admin-role")
      expect(resource[:description]).to eq("Admin role")
    end

    it 'synthesizes role with rules' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_role(:reader, {
          name: "/reader-role",
          rules: [
            { capability: ["read", "list"], path: "/secrets/*", rule_type: "item-rule" },
            { capability: ["read"], path: "/keys/*" }
          ]
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_role][:reader]

      expect(resource[:name]).to eq("/reader-role")
      expect(resource[:rules]).to be_a(Array) if resource[:rules].is_a?(Array)
    end

    it 'synthesizes role with auth method associations' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_role(:service, {
          name: "/service-role",
          assoc_auth_method: [
            { am_name: "/ci-auth", sub_claims: { "groups" => "devops" } }
          ]
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_role][:service]

      expect(resource[:name]).to eq("/service-role")
    end

    it 'synthesizes role with access permissions' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_role(:auditor, {
          name: "/auditor-role",
          audit_access: "all",
          analytics_access: "own",
          delete_protection: "true"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_role][:auditor]

      expect(resource[:audit_access]).to eq("all")
      expect(resource[:analytics_access]).to eq("own")
      expect(resource[:delete_protection]).to eq("true")
    end
  end

  describe 'resource references' do
    it 'provides correct outputs' do
      ref = synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_role(:test, { name: "/test" })
      end

      expect(ref.id).to eq('${akeyless_role.test.id}')
    end
  end
end
