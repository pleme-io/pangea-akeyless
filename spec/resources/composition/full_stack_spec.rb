# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'

RSpec.describe 'Akeyless full stack composition' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'auth + role + secret workflow' do
    it 'synthesizes a complete auth/role/secret stack' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless

        # Create auth method
        auth_ref = akeyless_auth_method_api_key(:ci, { name: "/ci-auth" })

        # Create role with rules
        role_ref = akeyless_role(:ci_reader, {
          name: "/ci-reader",
          rules: [
            { capability: ["read", "list"], path: "/secrets/*" }
          ]
        })

        # Associate role with auth method
        akeyless_associate_role_auth_method(:ci_binding, {
          role_name: role_ref.outputs[:name],
          am_name: auth_ref.outputs[:access_id]
        })

        # Create folder
        akeyless_folder(:secrets, { name: "/secrets" })

        # Create secrets
        akeyless_static_secret(:db_pass, {
          path: "/secrets/db-password",
          value: "super-secret",
          type: "password",
          tags: ["production"]
        })
      end

      result = synthesizer.synthesis

      expect(result[:resource]).to have_key(:akeyless_auth_method_api_key)
      expect(result[:resource]).to have_key(:akeyless_role)
      expect(result[:resource]).to have_key(:akeyless_associate_role_auth_method)
      expect(result[:resource]).to have_key(:akeyless_folder)
      expect(result[:resource]).to have_key(:akeyless_static_secret)

      # Verify cross-references
      assoc = result[:resource][:akeyless_associate_role_auth_method][:ci_binding]
      expect(assoc[:role_name]).to eq('${akeyless_role.ci_reader.name}')
      expect(assoc[:am_name]).to eq('${akeyless_auth_method_api_key.ci.access_id}')
    end
  end

  describe 'target + dynamic secret workflow' do
    it 'synthesizes AWS target with dynamic secret' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless

        target_ref = akeyless_aws_target(:aws_prod, {
          name: "/targets/aws-prod",
          access_key_id: "AKIAIOSFODNN7EXAMPLE",
          access_key: "secret-key",
          region: "us-west-2"
        })

        akeyless_dynamic_secret_aws(:ci_creds, {
          name: "/dynamic/aws-ci",
          target_name: target_ref.outputs[:name],
          access_mode: "iam_user",
          user_ttl: "1h",
          tags: ["ci", "aws"]
        })
      end

      result = synthesizer.synthesis

      target = result[:resource][:akeyless_aws_target][:aws_prod]
      expect(target[:region]).to eq("us-west-2")

      dynamic = result[:resource][:akeyless_dynamic_secret_aws][:ci_creds]
      expect(dynamic[:target_name]).to eq('${akeyless_aws_target.aws_prod.name}')
      expect(dynamic[:user_ttl]).to eq("1h")
      expect(dynamic[:tags]).to eq(["ci", "aws"])
    end
  end

  describe 'PKI workflow' do
    it 'synthesizes key + cert issuer chain' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless

        key_ref = akeyless_classic_key(:ca_key, {
          name: "/keys/ca",
          alg: "RSA4096",
          generate_self_signed_certificate: true,
          certificate_ttl: 3650,
          certificate_common_name: "Pleme Root CA"
        })

        akeyless_pki_cert_issuer(:internal, {
          name: "/pki/internal",
          signer_key_name: key_ref.outputs[:name],
          ttl: "8760h",
          allowed_domains: "*.internal.pleme.io",
          allow_subdomains: true,
          server_flag: true,
          client_flag: true
        })

        akeyless_ssh_cert_issuer(:bastion, {
          name: "/ssh/bastion",
          signer_key_name: key_ref.outputs[:name],
          allowed_users: "ubuntu,admin",
          ttl: 3600,
          extensions: { "permit-pty" => "" }
        })
      end

      result = synthesizer.synthesis

      key = result[:resource][:akeyless_classic_key][:ca_key]
      expect(key[:alg]).to eq("RSA4096")
      expect(key[:generate_self_signed_certificate]).to be true

      pki = result[:resource][:akeyless_pki_cert_issuer][:internal]
      expect(pki[:signer_key_name]).to eq('${akeyless_classic_key.ca_key.name}')
      expect(pki[:allow_subdomains]).to be true

      ssh = result[:resource][:akeyless_ssh_cert_issuer][:bastion]
      expect(ssh[:signer_key_name]).to eq('${akeyless_classic_key.ca_key.name}')
    end
  end

  describe 'mixed resources and data sources' do
    it 'synthesizes both resource and data blocks' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless

        # Resource
        akeyless_static_secret(:config, { path: "/app/config", value: "v1" })

        # Data source
        data_akeyless_static_secret(:existing, { path: "/shared/secret" })
      end

      result = synthesizer.synthesis

      expect(result[:resource][:akeyless_static_secret][:config][:path]).to eq("/app/config")
      expect(result[:data][:akeyless_static_secret][:existing][:path]).to eq("/shared/secret")
    end
  end
end
