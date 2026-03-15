# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/data_akeyless_auth/resource'

RSpec.describe 'data_akeyless_auth synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes auth data source' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        data_akeyless_auth(:login, {
          access_id: "p-1234567890",
          access_key: "my-access-key"
        })
      end

      result = synthesizer.synthesis
      data = result[:data][:akeyless_auth][:login]

      expect(data[:access_id]).to eq("p-1234567890")
      expect(data[:access_key]).to eq("my-access-key")
    end
  end

  describe 'resource references' do
    it 'provides token output' do
      ref = synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        data_akeyless_auth(:test, {
          access_id: "p-test",
          access_key: "key"
        })
      end

      expect(ref.outputs[:token]).to eq('${data.akeyless_auth.test.token}')
    end
  end
end
