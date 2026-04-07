# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'All resource families synthesis' do
  include Pangea::Testing::SynthesisTestHelpers
  include Pangea::Testing::ResourceExamples

  RESOURCE_FAMILIES = {
    akeyless_auth_method_aws_iam: {
      required: { name: '/auth/aws', bound_aws_account_id: ['123456789'] },
      desc: 'AWS IAM auth method'
    },
    akeyless_auth_method_azure_ad: {
      required: { name: '/auth/azure', bound_tenant_id: 'tenant-id-123' },
      desc: 'Azure AD auth method'
    },
    akeyless_auth_method_cert: {
      required: { name: '/auth/cert', unique_identifier: 'CN' },
      desc: 'certificate auth method'
    },
    akeyless_auth_method_gcp: {
      required: { name: '/auth/gcp', type: 'iam', audience: 'https://akeyless.io' },
      desc: 'GCP auth method'
    },
    akeyless_auth_method_k8s: {
      required: { name: '/auth/k8s' },
      desc: 'Kubernetes auth method'
    },
    akeyless_auth_method_oidc: {
      required: { name: '/auth/oidc', unique_identifier: 'email' },
      desc: 'OIDC auth method'
    },
    akeyless_auth_method_saml: {
      required: { name: '/auth/saml', unique_identifier: 'email' },
      desc: 'SAML auth method'
    },
    akeyless_dynamic_secret_aws: {
      required: { name: '/ds/aws' },
      desc: 'AWS dynamic secret'
    },
    akeyless_dynamic_secret_mysql: {
      required: { name: '/ds/mysql' },
      desc: 'MySQL dynamic secret'
    },
    akeyless_dynamic_secret_mongodb: {
      required: { name: '/ds/mongodb' },
      desc: 'MongoDB dynamic secret'
    },
    akeyless_dynamic_secret_github: {
      required: { name: '/ds/github' },
      desc: 'GitHub dynamic secret'
    },
    akeyless_target_db: {
      required: { name: '/target/db', db_type: 'postgres', connection_type: 'credentials' },
      desc: 'database target'
    },
    akeyless_target_ssh: {
      required: { name: '/target/ssh' },
      desc: 'SSH target'
    },
    akeyless_target_gcp: {
      required: { name: '/target/gcp' },
      desc: 'GCP target'
    },
    akeyless_rotated_secret_mysql: {
      required: { name: '/rs/mysql', target_name: '/target/mysql', rotator_type: 'target' },
      desc: 'MySQL rotated secret'
    },
    akeyless_rotated_secret_postgresql: {
      required: { name: '/rs/pg', target_name: '/target/pg', rotator_type: 'target' },
      desc: 'PostgreSQL rotated secret'
    },
    akeyless_pki_cert_issuer: {
      required: { name: '/pki/issuer', ttl: '3600' },
      desc: 'PKI certificate issuer'
    },
    akeyless_ssh_cert_issuer: {
      required: { name: '/ssh/issuer', signer_key_name: '/my/key', ttl: 3600, allowed_users: 'root' },
      desc: 'SSH certificate issuer'
    },
    akeyless_role_auth_method_assoc: {
      required: { am_name: '/auth-method', role_name: '/role' },
      desc: 'role-auth-method association'
    },
    akeyless_role_rule: {
      required: { path: '/secret/path', role_name: '/role', capability: ['read'] },
      desc: 'role rule'
    },
    akeyless_certificate: {
      required: { name: '/cert' },
      desc: 'certificate'
    },
    akeyless_kmip_environment: {
      required: { hostname: 'kmip.example.com', root: '/kmip' },
      desc: 'KMIP environment'
    },
    akeyless_group: {
      required: { name: '/my/group', group_alias: 'my-group' },
      desc: 'group'
    },
    akeyless_account_custom_field: {
      required: { name: 'custom-field', object: 'item', object_type: 'string' },
      desc: 'account custom field'
    },
    akeyless_event_forwarder_email: {
      required: {
        name: '/fwd/email',
        gateways_event_source_locations: ['gw1'],
        runner_type: 'gateway'
      },
      desc: 'email event forwarder'
    },
    akeyless_event_forwarder_webhook: {
      required: {
        name: '/fwd/webhook',
        gateways_event_source_locations: ['gw1'],
        runner_type: 'gateway'
      },
      desc: 'webhook event forwarder'
    },
  }.freeze

  RESOURCE_FAMILIES.each do |resource_type, config|
    describe "#{resource_type} (#{config[:desc]})" do
      it_behaves_like 'a pangea resource',
        resource_type: resource_type,
        provider: Pangea::Resources::Akeyless,
        required_attrs: config[:required],
        expected_outputs: [:id, :name]
    end
  end
end
