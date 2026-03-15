# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_folder/resource'

RSpec.describe 'akeyless_folder synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes basic folder' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_folder(:secrets, {
          name: "/pleme/secrets"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_folder][:secrets]

      expect(resource[:name]).to eq("/pleme/secrets")
    end

    it 'synthesizes folder with description and tags' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_folder(:production, {
          name: "/pleme/production",
          description: "Production secrets folder",
          tags: ["production", "secrets"]
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_folder][:production]

      expect(resource[:description]).to eq("Production secrets folder")
      expect(resource[:tags]).to eq(["production", "secrets"])
    end
  end
end
