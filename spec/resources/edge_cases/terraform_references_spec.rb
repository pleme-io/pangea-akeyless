# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'

RSpec.describe 'edge cases' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform reference passthrough' do
    it 'passes terraform interpolation strings through unchanged' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_static_secret(:ref_test, {
          path: "/test",
          value: "${data.akeyless_secret.existing.value}",
          description: "${var.description}"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_static_secret][:ref_test]

      expect(resource[:value]).to eq("${data.akeyless_secret.existing.value}")
      expect(resource[:description]).to eq("${var.description}")
    end
  end

  describe 'empty arrays not emitted' do
    it 'does not emit empty tags' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_static_secret(:no_tags, { path: "/test" })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_static_secret][:no_tags]

      expect(resource).not_to have_key(:tags)
    end

    it 'does not emit empty bound_ips' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_auth_method_api_key(:no_ips, { name: "/test" })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_auth_method_api_key][:no_ips]

      expect(resource).not_to have_key(:bound_ips)
    end
  end

  describe 'resource reference outputs' do
    it 'returns properly formatted reference objects' do
      ref = synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_static_secret(:test, { path: "/test" })
      end

      expect(ref).to be_a(Pangea::Resources::ResourceReference)
      expect(ref.type).to eq('akeyless_static_secret')
      expect(ref.id).to eq('${akeyless_static_secret.test.id}')
      expect(ref.outputs).to be_a(Hash)
      expect(ref.outputs).to include(:id, :path, :version)
    end

    it 'returns reference with correct resource_attributes' do
      ref = synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_auth_method_api_key(:test, {
          name: "/test",
          access_expires: 3600
        })
      end

      expect(ref.resource_attributes[:name]).to eq("/test")
      expect(ref.resource_attributes[:access_expires]).to eq(3600)
    end
  end

  describe 'multiple resources of same type' do
    it 'synthesizes multiple instances without collision' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_static_secret(:secret_a, { path: "/a" })
        akeyless_static_secret(:secret_b, { path: "/b" })
        akeyless_static_secret(:secret_c, { path: "/c" })
      end

      result = synthesizer.synthesis
      secrets = result[:resource][:akeyless_static_secret]

      expect(secrets).to have_key(:secret_a)
      expect(secrets).to have_key(:secret_b)
      expect(secrets).to have_key(:secret_c)
      expect(secrets[:secret_a][:path]).to eq("/a")
      expect(secrets[:secret_b][:path]).to eq("/b")
      expect(secrets[:secret_c][:path]).to eq("/c")
    end
  end

  describe 'special characters in values' do
    it 'handles newlines in secret values' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_static_secret(:multiline, {
          path: "/test",
          value: "line1\nline2\nline3"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_static_secret][:multiline]
      expect(resource[:value]).to eq("line1\nline2\nline3")
    end

    it 'handles unicode in descriptions' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_folder(:unicode, {
          name: "/test",
          description: "Production secrets (prod)"
        })
      end

      result = synthesizer.synthesis
      expect(result[:resource][:akeyless_folder][:unicode][:description]).to include("prod")
    end
  end
end
