# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/akeyless_role/types'

RSpec.describe Pangea::Resources::Akeyless::Types::RoleAttributes do
  describe 'required attributes' do
    it 'requires name' do
      expect { described_class.new({}) }.to raise_error(Dry::Struct::Error, /name/)
    end

    it 'accepts minimal attributes' do
      attrs = described_class.new(name: '/test')
      expect(attrs.name).to eq('/test')
    end
  end

  describe 'defaults' do
    let(:attrs) { described_class.new(name: '/test') }

    it 'defaults rules to empty array' do
      expect(attrs.rules).to eq([])
    end

    it 'defaults assoc_auth_method to empty array' do
      expect(attrs.assoc_auth_method).to eq([])
    end

    it 'defaults delete_protection to nil' do
      expect(attrs.delete_protection).to be_nil
    end
  end

  describe 'nested rules' do
    it 'accepts valid rules' do
      attrs = described_class.new(
        name: '/test',
        rules: [{ capability: ['read', 'list'], path: '/secrets/*' }]
      )
      expect(attrs.rules.length).to eq(1)
      expect(attrs.rules.first.capability).to eq(['read', 'list'])
      expect(attrs.rules.first.path).to eq('/secrets/*')
      expect(attrs.rules.first.rule_type).to eq('item-rule')
    end

    it 'requires capability in rules' do
      expect {
        described_class.new(name: '/test', rules: [{ path: '/secrets/*' }])
      }.to raise_error(Dry::Struct::Error)
    end

    it 'requires path in rules' do
      expect {
        described_class.new(name: '/test', rules: [{ capability: ['read'] }])
      }.to raise_error(Dry::Struct::Error)
    end

    it 'accepts multiple rules' do
      attrs = described_class.new(
        name: '/test',
        rules: [
          { capability: ['read'], path: '/secrets/*' },
          { capability: ['create', 'update', 'delete'], path: '/admin/*', rule_type: 'role-rule' }
        ]
      )
      expect(attrs.rules.length).to eq(2)
      expect(attrs.rules.last.rule_type).to eq('role-rule')
    end
  end

  describe 'nested assoc_auth_method' do
    it 'accepts valid association' do
      attrs = described_class.new(
        name: '/test',
        assoc_auth_method: [{ am_name: '/my-auth' }]
      )
      expect(attrs.assoc_auth_method.length).to eq(1)
      expect(attrs.assoc_auth_method.first.am_name).to eq('/my-auth')
      expect(attrs.assoc_auth_method.first.case_sensitive).to eq('true')
      expect(attrs.assoc_auth_method.first.sub_claims).to eq({})
    end

    it 'accepts association with sub_claims' do
      attrs = described_class.new(
        name: '/test',
        assoc_auth_method: [{
          am_name: '/oidc-auth',
          sub_claims: { 'groups' => 'engineering' },
          case_sensitive: 'false'
        }]
      )
      expect(attrs.assoc_auth_method.first.sub_claims).to eq({ 'groups' => 'engineering' })
    end

    it 'requires am_name in association' do
      expect {
        described_class.new(name: '/test', assoc_auth_method: [{ sub_claims: {} }])
      }.to raise_error(Dry::Struct::Error)
    end
  end
end
