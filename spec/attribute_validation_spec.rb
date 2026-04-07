# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Dry::Struct attribute validation' do
  describe Pangea::Resources::Akeyless::Types::FolderAttributes do
    it 'requires name attribute' do
      expect { described_class.new({}) }.to raise_error(Dry::Struct::Error)
    end

    it 'accepts valid minimal attributes' do
      attrs = described_class.new(name: '/my/folder')
      expect(attrs.name).to eq('/my/folder')
    end

    it 'coerces string keys to symbols' do
      attrs = described_class.new('name' => '/my/folder')
      expect(attrs.name).to eq('/my/folder')
    end

    it 'accepts all optional attributes' do
      attrs = described_class.new(
        name: '/my/folder',
        description: 'desc',
        tags: ['tag1'],
        delete_protection: true,
        accessibility: 'regular',
        type: 'folder'
      )
      expect(attrs.description).to eq('desc')
      expect(attrs.tags).to eq(['tag1'])
      expect(attrs.delete_protection).to eq(true)
    end

    it 'accepts nil for optional attributes' do
      attrs = described_class.new(name: '/folder', description: nil)
      expect(attrs.description).to be_nil
    end

    it 'rejects wrong type for name' do
      expect { described_class.new(name: 123) }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects wrong type for delete_protection' do
      expect { described_class.new(name: '/f', delete_protection: 'yes') }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects wrong type for tags (expects array)' do
      expect { described_class.new(name: '/f', tags: 'single') }.to raise_error(Dry::Struct::Error)
    end
  end

  describe Pangea::Resources::Akeyless::Types::AuthMethodApiKeyAttributes do
    it 'requires name attribute' do
      expect { described_class.new({}) }.to raise_error(Dry::Struct::Error)
    end

    it 'accepts valid minimal attributes' do
      attrs = described_class.new(name: '/auth/key')
      expect(attrs.name).to eq('/auth/key')
    end

    it 'accepts integer attributes' do
      attrs = described_class.new(name: '/auth/key', jwt_ttl: 3600, access_expires: 1000)
      expect(attrs.jwt_ttl).to eq(3600)
      expect(attrs.access_expires).to eq(1000)
    end

    it 'rejects string for integer field' do
      expect { described_class.new(name: '/auth/key', jwt_ttl: 'abc') }.to raise_error(Dry::Struct::Error)
    end

    it 'accepts array of strings for bound_ips' do
      attrs = described_class.new(name: '/auth/key', bound_ips: ['10.0.0.1', '10.0.0.2'])
      expect(attrs.bound_ips).to eq(['10.0.0.1', '10.0.0.2'])
    end

    it 'accepts empty array for bound_ips' do
      attrs = described_class.new(name: '/auth/key', bound_ips: [])
      expect(attrs.bound_ips).to eq([])
    end

    it 'accepts boolean attributes' do
      attrs = described_class.new(name: '/auth/key', delete_protection: false, force_sub_claims: true)
      expect(attrs.delete_protection).to eq(false)
      expect(attrs.force_sub_claims).to eq(true)
    end
  end

  describe Pangea::Resources::Akeyless::Types::StaticSecretAttributes do
    it 'requires name and value' do
      expect { described_class.new(name: '/secret') }.to raise_error(Dry::Struct::Error)
    end

    it 'accepts valid attributes' do
      attrs = described_class.new(name: '/secret', value: 'my-secret-val')
      expect(attrs.name).to eq('/secret')
      expect(attrs.value).to eq('my-secret-val')
    end

    it 'accepts empty string value' do
      attrs = described_class.new(name: '/secret', value: '')
      expect(attrs.value).to eq('')
    end
  end

  describe Pangea::Resources::Akeyless::Types::TargetAwsAttributes do
    it 'requires name, access_key, and access_key_id' do
      expect { described_class.new(name: '/target') }.to raise_error(Dry::Struct::Error)
      expect { described_class.new(name: '/target', access_key: 'k') }.to raise_error(Dry::Struct::Error)
    end

    it 'accepts valid required attributes' do
      attrs = described_class.new(
        name: '/target',
        access_key: 'AKIAEXAMPLE',
        access_key_id: 'secret-key'
      )
      expect(attrs.name).to eq('/target')
      expect(attrs.access_key).to eq('AKIAEXAMPLE')
      expect(attrs.access_key_id).to eq('secret-key')
    end
  end

  describe Pangea::Resources::Akeyless::Types::ClassicKeyAttributes do
    it 'requires name and alg' do
      expect { described_class.new(name: '/key') }.to raise_error(Dry::Struct::Error)
    end

    it 'accepts valid attributes' do
      attrs = described_class.new(name: '/key', alg: 'RSA2048')
      expect(attrs.name).to eq('/key')
      expect(attrs.alg).to eq('RSA2048')
    end

    it 'accepts expiration_event_in as array of strings' do
      attrs = described_class.new(name: '/key', alg: 'AES256GCM', expiration_event_in: ['30d', '7d'])
      expect(attrs.expiration_event_in).to eq(['30d', '7d'])
    end

    it 'accepts certificate_ttl as integer' do
      attrs = described_class.new(name: '/key', alg: 'RSA2048', certificate_ttl: 365)
      expect(attrs.certificate_ttl).to eq(365)
    end
  end

  describe Pangea::Resources::Akeyless::Types::DynamicSecretPostgresqlAttributes do
    it 'requires only name' do
      attrs = described_class.new(name: '/pg-secret')
      expect(attrs.name).to eq('/pg-secret')
    end

    it 'accepts all postgres connection attributes' do
      attrs = described_class.new(
        name: '/pg',
        postgresql_host: 'localhost',
        postgresql_port: '5432',
        postgresql_db_name: 'testdb',
        postgresql_username: 'admin',
        postgresql_password: 'pass',
        ssl: true,
        user_ttl: '1h'
      )
      expect(attrs.postgresql_host).to eq('localhost')
      expect(attrs.ssl).to eq(true)
    end

    it 'accepts secure_access_delay as integer' do
      attrs = described_class.new(name: '/pg', secure_access_delay: 30)
      expect(attrs.secure_access_delay).to eq(30)
    end
  end

  describe Pangea::Resources::Akeyless::Types::RoleAttributes do
    it 'requires name' do
      expect { described_class.new({}) }.to raise_error(Dry::Struct::Error)
    end

    it 'accepts all access control fields' do
      attrs = described_class.new(
        name: '/role',
        analytics_access: 'read',
        audit_access: 'read',
        event_center_access: 'none',
        gw_analytics_access: 'admin'
      )
      expect(attrs.analytics_access).to eq('read')
      expect(attrs.audit_access).to eq('read')
    end

    it 'accepts event_forwarders_name as array' do
      attrs = described_class.new(name: '/role', event_forwarders_name: ['fwd1', 'fwd2'])
      expect(attrs.event_forwarders_name).to eq(['fwd1', 'fwd2'])
    end
  end

  describe Pangea::Resources::Akeyless::Types::PolicyAttributes do
    it 'requires path' do
      expect { described_class.new({}) }.to raise_error(Dry::Struct::Error)
    end

    it 'accepts valid attributes' do
      attrs = described_class.new(
        path: '/policy',
        allowed_algorithms: ['RSA2048'],
        max_rotation_interval_days: 90
      )
      expect(attrs.path).to eq('/policy')
      expect(attrs.max_rotation_interval_days).to eq(90)
    end
  end
end
