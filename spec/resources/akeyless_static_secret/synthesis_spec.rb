# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_static_secret/resource'

RSpec.describe 'akeyless_static_secret synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes basic secret' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_static_secret(:my_secret, {
          path: "/pleme/test-secret"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_static_secret][:my_secret]

      expect(resource[:path]).to eq("/pleme/test-secret")
    end

    it 'synthesizes secret with value and metadata' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_static_secret(:db_password, {
          path: "/pleme/db/password",
          value: "super-secret-value",
          type: "password",
          description: "Production DB password",
          tags: ["production", "database"],
          username: "admin"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_static_secret][:db_password]

      expect(resource[:path]).to eq("/pleme/db/password")
      expect(resource[:value]).to eq("super-secret-value")
      expect(resource[:type]).to eq("password")
      expect(resource[:description]).to eq("Production DB password")
      expect(resource[:tags]).to eq(["production", "database"])
      expect(resource[:username]).to eq("admin")
    end

    it 'synthesizes multiline secret' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_static_secret(:config, {
          path: "/pleme/config",
          value: '{"key": "value"}',
          multiline_value: true
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_static_secret][:config]

      expect(resource[:path]).to eq("/pleme/config")
      expect(resource[:multiline_value]).to be true
    end
  end

  describe 'resource references' do
    it 'provides path and version outputs' do
      ref = synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_static_secret(:test, { path: "/test" })
      end

      expect(ref.id).to eq('${akeyless_static_secret.test.id}')
      expect(ref.outputs[:path]).to eq('${akeyless_static_secret.test.path}')
      expect(ref.outputs[:version]).to eq('${akeyless_static_secret.test.version}')
    end
  end
end
