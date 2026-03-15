# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_dynamic_secret_aws/resource'

RSpec.describe 'akeyless_dynamic_secret_aws synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes IAM user dynamic secret' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_dynamic_secret_aws(:ci_creds, {
          name: "/dynamic/aws-ci",
          target_name: "/targets/aws-prod",
          access_mode: "iam_user",
          aws_user_policies: "arn:aws:iam::aws:policy/ReadOnlyAccess",
          user_ttl: "1h"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_dynamic_secret_aws][:ci_creds]

      expect(resource[:name]).to eq("/dynamic/aws-ci")
      expect(resource[:target_name]).to eq("/targets/aws-prod")
      expect(resource[:access_mode]).to eq("iam_user")
      expect(resource[:user_ttl]).to eq("1h")
    end

    it 'synthesizes assume role dynamic secret' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_dynamic_secret_aws(:deploy, {
          name: "/dynamic/aws-deploy",
          target_name: "/targets/aws-prod",
          access_mode: "assume_role",
          aws_role_arns: "arn:aws:iam::123456789012:role/deploy-role",
          user_ttl: "30m",
          tags: ["deploy", "production"]
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_dynamic_secret_aws][:deploy]

      expect(resource[:access_mode]).to eq("assume_role")
      expect(resource[:aws_role_arns]).to eq("arn:aws:iam::123456789012:role/deploy-role")
      expect(resource[:tags]).to eq(["deploy", "production"])
    end
  end
end
