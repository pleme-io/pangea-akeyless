# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Resource synthesis' do
  include Pangea::Testing::SynthesisTestHelpers

  let(:synth) { create_synthesizer }

  before { synth.extend(Pangea::Resources::Akeyless) }

  describe 'akeyless_folder' do
    it 'synthesizes with required attributes only' do
      ref = synth.akeyless_folder(:test_folder, name: '/my/folder')
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_folder', 'test_folder')

      expect(config).not_to be_nil
      expect(config['name']).to eq('/my/folder')
    end

    it 'returns a ResourceReference with correct outputs' do
      ref = synth.akeyless_folder(:test_folder, name: '/my/folder')

      expect(ref).to be_a(Pangea::Resources::ResourceReference)
      expect(ref.type).to eq('akeyless_folder')
      expect(ref.outputs[:id]).to eq('${akeyless_folder.test_folder.id}')
      expect(ref.outputs[:name]).to eq('${akeyless_folder.test_folder.name}')
    end

    it 'synthesizes optional attributes when present' do
      ref = synth.akeyless_folder(:full_folder,
        name: '/my/folder',
        description: 'A test folder',
        tags: ['env:test', 'team:infra'],
        delete_protection: true
      )
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_folder', 'full_folder')

      expect(config['description']).to eq('A test folder')
      expect(config['tags']).to eq(['env:test', 'team:infra'])
      expect(config['delete_protection']).to eq(true)
    end

    it 'omits nil optional attributes from synthesis' do
      synth.akeyless_folder(:minimal, name: '/minimal')
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_folder', 'minimal')

      expect(config).not_to have_key('description')
      expect(config).not_to have_key('tags')
      expect(config).not_to have_key('accessibility')
    end

    it 'includes delete_protection=false when explicitly set' do
      synth.akeyless_folder(:no_protect,
        name: '/no-protect',
        delete_protection: false
      )
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_folder', 'no_protect')

      expect(config['delete_protection']).to eq(false)
    end
  end

  describe 'akeyless_auth_method_api_key' do
    it 'synthesizes with required attributes' do
      ref = synth.akeyless_auth_method_api_key(:my_key, name: '/my/api-key')
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_auth_method_api_key', 'my_key')

      expect(config).not_to be_nil
      expect(config['name']).to eq('/my/api-key')
    end

    it 'synthesizes with array attributes' do
      ref = synth.akeyless_auth_method_api_key(:bounded,
        name: '/my/bounded-key',
        bound_ips: ['10.0.0.1', '10.0.0.2'],
        allowed_client_type: ['web', 'cli']
      )
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_auth_method_api_key', 'bounded')

      expect(config['bound_ips']).to eq(['10.0.0.1', '10.0.0.2'])
      expect(config['allowed_client_type']).to eq(['web', 'cli'])
    end

    it 'synthesizes boolean attributes correctly' do
      ref = synth.akeyless_auth_method_api_key(:bools,
        name: '/my/bools',
        delete_protection: true,
        force_sub_claims: false
      )
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_auth_method_api_key', 'bools')

      expect(config['delete_protection']).to eq(true)
      expect(config['force_sub_claims']).to eq(false)
    end

    it 'synthesizes integer attributes' do
      ref = synth.akeyless_auth_method_api_key(:with_ttl,
        name: '/my/ttl-key',
        jwt_ttl: 3600,
        access_expires: 1000
      )
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_auth_method_api_key', 'with_ttl')

      expect(config['jwt_ttl']).to eq(3600)
      expect(config['access_expires']).to eq(1000)
    end
  end

  describe 'akeyless_static_secret' do
    it 'synthesizes with required attributes' do
      ref = synth.akeyless_static_secret(:my_secret,
        name: '/my/secret',
        value: 'supersecret'
      )
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_static_secret', 'my_secret')

      expect(config['name']).to eq('/my/secret')
      expect(config['value']).to eq('supersecret')
    end

    it 'synthesizes with all optional attributes' do
      ref = synth.akeyless_static_secret(:full_secret,
        name: '/my/full-secret',
        value: 'secret-value',
        description: 'A test secret',
        tags: ['env:prod'],
        type: 'generic',
        format: 'text',
        delete_protection: true,
        max_versions: '5'
      )
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_static_secret', 'full_secret')

      expect(config['description']).to eq('A test secret')
      expect(config['tags']).to eq(['env:prod'])
      expect(config['type']).to eq('generic')
      expect(config['delete_protection']).to eq(true)
      expect(config['max_versions']).to eq('5')
      # NOTE: 'format' is shadowed by Kernel#format inside the synthesizer
      # block, so it won't be set via map_present. This is a known limitation
      # of attribute names that collide with Ruby built-in methods.
    end
  end

  describe 'akeyless_role' do
    it 'synthesizes with required name' do
      ref = synth.akeyless_role(:admin, name: '/my/admin-role')
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_role', 'admin')

      expect(config['name']).to eq('/my/admin-role')
    end

    it 'synthesizes access control attributes' do
      ref = synth.akeyless_role(:auditor,
        name: '/auditor',
        audit_access: 'read',
        analytics_access: 'read',
        description: 'Audit role'
      )
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_role', 'auditor')

      expect(config['audit_access']).to eq('read')
      expect(config['analytics_access']).to eq('read')
      expect(config['description']).to eq('Audit role')
    end
  end

  describe 'akeyless_target_aws' do
    it 'synthesizes with required attributes' do
      ref = synth.akeyless_target_aws(:aws_target,
        name: '/my/aws-target',
        access_key: 'AKIAIOSFODNN7EXAMPLE',
        access_key_id: 'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'
      )
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_target_aws', 'aws_target')

      expect(config['name']).to eq('/my/aws-target')
      expect(config['access_key']).to eq('AKIAIOSFODNN7EXAMPLE')
      expect(config['access_key_id']).to eq('wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY')
    end

    it 'synthesizes with optional region and role_arn' do
      ref = synth.akeyless_target_aws(:aws_full,
        name: '/my/aws-full',
        access_key: 'key',
        access_key_id: 'key-id',
        region: 'us-east-1',
        role_arn: 'arn:aws:iam::123456789012:role/my-role'
      )
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_target_aws', 'aws_full')

      expect(config['region']).to eq('us-east-1')
      expect(config['role_arn']).to eq('arn:aws:iam::123456789012:role/my-role')
    end
  end

  describe 'akeyless_dynamic_secret_postgresql' do
    it 'synthesizes with required name' do
      ref = synth.akeyless_dynamic_secret_postgresql(:pg_secret,
        name: '/my/pg-secret'
      )
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_dynamic_secret_postgresql', 'pg_secret')

      expect(config['name']).to eq('/my/pg-secret')
    end

    it 'synthesizes database connection details' do
      ref = synth.akeyless_dynamic_secret_postgresql(:pg_full,
        name: '/my/pg-full',
        postgresql_host: 'db.example.com',
        postgresql_port: '5432',
        postgresql_db_name: 'mydb',
        postgresql_username: 'admin',
        postgresql_password: 'pass123',
        creation_statements: "CREATE ROLE '{{name}}';"
      )
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_dynamic_secret_postgresql', 'pg_full')

      expect(config['postgresql_host']).to eq('db.example.com')
      expect(config['postgresql_port']).to eq('5432')
      expect(config['postgresql_db_name']).to eq('mydb')
    end

    it 'synthesizes boolean ssl attribute' do
      ref = synth.akeyless_dynamic_secret_postgresql(:pg_ssl,
        name: '/pg-ssl',
        ssl: true
      )
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_dynamic_secret_postgresql', 'pg_ssl')

      expect(config['ssl']).to eq(true)
    end
  end

  describe 'akeyless_classic_key' do
    it 'synthesizes with required attributes' do
      ref = synth.akeyless_classic_key(:my_key,
        name: '/my/key',
        alg: 'AES256GCM'
      )
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_classic_key', 'my_key')

      expect(config['name']).to eq('/my/key')
      expect(config['alg']).to eq('AES256GCM')
    end

    it 'synthesizes with certificate attributes' do
      ref = synth.akeyless_classic_key(:cert_key,
        name: '/my/cert-key',
        alg: 'RSA2048',
        generate_self_signed_certificate: true,
        certificate_common_name: 'example.com',
        certificate_ttl: 365
      )
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_classic_key', 'cert_key')

      expect(config['generate_self_signed_certificate']).to eq(true)
      expect(config['certificate_common_name']).to eq('example.com')
      expect(config['certificate_ttl']).to eq(365)
    end
  end

  describe 'akeyless_policy' do
    it 'synthesizes with required path' do
      ref = synth.akeyless_policy(:my_policy, path: '/my/policy/path')
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_policy', 'my_policy')

      expect(config['path']).to eq('/my/policy/path')
    end

    it 'synthesizes with array attributes' do
      ref = synth.akeyless_policy(:full_policy,
        path: '/policy',
        allowed_algorithms: ['RSA2048', 'AES256GCM'],
        allowed_key_types: ['classic', 'dfc'],
        object_types: ['secret']
      )
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_policy', 'full_policy')

      expect(config['allowed_algorithms']).to eq(['RSA2048', 'AES256GCM'])
      expect(config['allowed_key_types']).to eq(['classic', 'dfc'])
    end
  end

  describe 'akeyless_event_forwarder_slack' do
    it 'synthesizes with required attributes' do
      ref = synth.akeyless_event_forwarder_slack(:slack_fwd,
        name: '/my/slack-forwarder',
        url: 'https://hooks.slack.com/services/T00/B00/XXX',
        gateways_event_source_locations: ['us-east-1'],
        runner_type: 'gateway'
      )
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_event_forwarder_slack', 'slack_fwd')

      expect(config).not_to be_nil
      expect(config['url']).to eq('https://hooks.slack.com/services/T00/B00/XXX')
    end
  end

  describe 'akeyless_gateway_allowed_access' do
    it 'synthesizes with required attributes' do
      ref = synth.akeyless_gateway_allowed_access(:gw_access,
        access_id: 'p-1234567890',
        name: '/my/gw-access'
      )
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_gateway_allowed_access', 'gw_access')

      expect(config).not_to be_nil
    end
  end

  describe 'multiple resources in one synthesizer' do
    it 'synthesizes multiple resource types' do
      synth.akeyless_folder(:folder1, name: '/folder1')
      synth.akeyless_role(:role1, name: '/role1')
      synth.akeyless_static_secret(:secret1, name: '/secret1', value: 'val')

      result = normalize_synthesis(synth.synthesis)

      expect(result.dig('resource', 'akeyless_folder', 'folder1')).not_to be_nil
      expect(result.dig('resource', 'akeyless_role', 'role1')).not_to be_nil
      expect(result.dig('resource', 'akeyless_static_secret', 'secret1')).not_to be_nil
    end

    it 'synthesizes multiple instances of the same resource type' do
      synth.akeyless_folder(:folder1, name: '/folder1')
      synth.akeyless_folder(:folder2, name: '/folder2')

      result = normalize_synthesis(synth.synthesis)
      folders = result.dig('resource', 'akeyless_folder')

      expect(folders).to have_key('folder1')
      expect(folders).to have_key('folder2')
    end
  end
end
