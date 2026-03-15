# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_auth_method_aws_iam/resource'

RSpec.describe 'akeyless_auth_method_aws_iam synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes AWS IAM auth method' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_auth_method_aws_iam(:prod, {
          name: "/prod-aws-iam",
          bound_aws_account_id: ["123456789012"]
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_auth_method_aws_iam][:prod]

      expect(resource[:name]).to eq("/prod-aws-iam")
      expect(resource[:bound_aws_account_id]).to eq(["123456789012"])
    end

    it 'synthesizes with role and ARN bindings' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_auth_method_aws_iam(:restricted, {
          name: "/restricted-aws",
          bound_aws_account_id: ["123456789012", "098765432109"],
          bound_arn: ["arn:aws:iam::123456789012:role/my-role"],
          bound_role_name: ["my-role"],
          sts_url: "https://sts.us-west-2.amazonaws.com"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_auth_method_aws_iam][:restricted]

      expect(resource[:bound_aws_account_id]).to include("123456789012")
      expect(resource[:bound_arn]).to eq(["arn:aws:iam::123456789012:role/my-role"])
      expect(resource[:sts_url]).to eq("https://sts.us-west-2.amazonaws.com")
    end
  end
end
