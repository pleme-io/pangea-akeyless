# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/data_akeyless_static_secret/resource'

RSpec.describe 'data_akeyless_static_secret synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes data source lookup' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        data_akeyless_static_secret(:db_pass, {
          path: "/pleme/db/password"
        })
      end

      result = synthesizer.synthesis
      data = result[:data][:akeyless_static_secret][:db_pass]

      expect(data[:path]).to eq("/pleme/db/password")
    end

    it 'synthesizes with version' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        data_akeyless_static_secret(:pinned, {
          path: "/pleme/config",
          version: 3
        })
      end

      result = synthesizer.synthesis
      data = result[:data][:akeyless_static_secret][:pinned]

      expect(data[:path]).to eq("/pleme/config")
      expect(data[:version]).to eq(3)
    end
  end

  describe 'resource references' do
    it 'provides data source interpolation strings' do
      ref = synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        data_akeyless_static_secret(:test, { path: "/test" })
      end

      expect(ref.outputs[:value]).to eq('${data.akeyless_static_secret.test.value}')
    end
  end
end
