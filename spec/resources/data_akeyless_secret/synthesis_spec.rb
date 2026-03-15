# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/data_akeyless_secret/resource'

RSpec.describe 'data_akeyless_secret synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes generic secret lookup' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        data_akeyless_secret(:api_key, {
          path: "/pleme/api-key"
        })
      end

      result = synthesizer.synthesis
      data = result[:data][:akeyless_secret][:api_key]

      expect(data[:path]).to eq("/pleme/api-key")
    end
  end
end
