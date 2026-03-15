# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/akeyless_auth_method_api_key/types'

RSpec.describe Pangea::Resources::Akeyless::Types::AuthMethodApiKeyAttributes do
  describe 'required attributes' do
    it 'requires name' do
      expect { described_class.new({}) }.to raise_error(Dry::Struct::Error, /name/)
    end
  end

  describe 'defaults' do
    let(:attrs) { described_class.new(name: '/test') }

    it 'defaults access_expires to 0' do
      expect(attrs.access_expires).to eq(0)
    end

    it 'defaults force_sub_claims to false' do
      expect(attrs.force_sub_claims).to be false
    end

    it 'defaults jwt_ttl to 0' do
      expect(attrs.jwt_ttl).to eq(0)
    end

    it 'defaults bound_ips to empty array' do
      expect(attrs.bound_ips).to eq([])
    end

    it 'defaults audit_logs_claims to empty array' do
      expect(attrs.audit_logs_claims).to eq([])
    end

    it 'defaults delete_protection to nil' do
      expect(attrs.delete_protection).to be_nil
    end
  end

  describe 'type coercion' do
    it 'rejects non-integer access_expires' do
      expect { described_class.new(name: '/test', access_expires: 'abc') }
        .to raise_error(Dry::Struct::Error)
    end

    it 'rejects non-boolean force_sub_claims' do
      expect { described_class.new(name: '/test', force_sub_claims: 'yes') }
        .to raise_error(Dry::Struct::Error)
    end

    it 'rejects non-array bound_ips' do
      expect { described_class.new(name: '/test', bound_ips: '10.0.0.0/8') }
        .to raise_error(Dry::Struct::Error)
    end
  end
end
