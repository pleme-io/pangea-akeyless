# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_aws_target/resource'

RSpec.describe 'akeyless_aws_target synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes AWS target' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_aws_target(:prod, {
          name: "/targets/aws-prod",
          access_key_id: "AKIAIOSFODNN7EXAMPLE",
          access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
          region: "us-west-2"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_aws_target][:prod]

      expect(resource[:name]).to eq("/targets/aws-prod")
      expect(resource[:access_key_id]).to eq("AKIAIOSFODNN7EXAMPLE")
      expect(resource[:region]).to eq("us-west-2")
    end

    it 'synthesizes with gateway cloud identity' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_aws_target(:gw, {
          name: "/targets/aws-gw",
          access_key_id: "AKIAIOSFODNN7EXAMPLE",
          use_gw_cloud_identity: true
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_aws_target][:gw]

      expect(resource[:use_gw_cloud_identity]).to be true
    end
  end
end
