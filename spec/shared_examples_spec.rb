# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Shared resource examples' do
  include Pangea::Testing::ResourceExamples

  describe 'akeyless_folder' do
    it_behaves_like 'a pangea resource',
      resource_type: :akeyless_folder,
      provider: Pangea::Resources::Akeyless,
      required_attrs: { name: '/test-folder' },
      expected_outputs: [:id, :name]
  end

  describe 'akeyless_role' do
    it_behaves_like 'a pangea resource',
      resource_type: :akeyless_role,
      provider: Pangea::Resources::Akeyless,
      required_attrs: { name: '/test-role' },
      expected_outputs: [:id, :name]
  end

  describe 'akeyless_static_secret' do
    it_behaves_like 'a pangea resource',
      resource_type: :akeyless_static_secret,
      provider: Pangea::Resources::Akeyless,
      required_attrs: { name: '/test-secret', value: 'v' },
      expected_outputs: [:id, :name]
  end

  describe 'akeyless_classic_key' do
    it_behaves_like 'a pangea resource',
      resource_type: :akeyless_classic_key,
      provider: Pangea::Resources::Akeyless,
      required_attrs: { name: '/test-key', alg: 'AES256GCM' },
      expected_outputs: [:id, :name]
  end

  describe 'akeyless_dfc_key' do
    it_behaves_like 'a pangea resource',
      resource_type: :akeyless_dfc_key,
      provider: Pangea::Resources::Akeyless,
      required_attrs: { name: '/test-dfc-key', alg: 'RSA2048' },
      expected_outputs: [:id, :name]
  end

  describe 'akeyless_auth_method_api_key' do
    it_behaves_like 'a pangea resource',
      resource_type: :akeyless_auth_method_api_key,
      provider: Pangea::Resources::Akeyless,
      required_attrs: { name: '/test-auth' },
      expected_outputs: [:id, :name]
  end

  describe 'akeyless_target_aws' do
    it_behaves_like 'a pangea resource',
      resource_type: :akeyless_target_aws,
      provider: Pangea::Resources::Akeyless,
      required_attrs: { name: '/test-target', access_key: 'k', access_key_id: 'kid' },
      expected_outputs: [:id, :name]
  end

  describe 'akeyless_dynamic_secret_postgresql' do
    it_behaves_like 'a pangea resource',
      resource_type: :akeyless_dynamic_secret_postgresql,
      provider: Pangea::Resources::Akeyless,
      required_attrs: { name: '/test-pg' },
      expected_outputs: [:id, :name]
  end

  describe 'akeyless_policy' do
    it_behaves_like 'a pangea resource',
      resource_type: :akeyless_policy,
      provider: Pangea::Resources::Akeyless,
      required_attrs: { path: '/test-policy' },
      expected_outputs: [:id, :name]
  end

  describe 'akeyless_event_forwarder_slack' do
    it_behaves_like 'a pangea resource',
      resource_type: :akeyless_event_forwarder_slack,
      provider: Pangea::Resources::Akeyless,
      required_attrs: {
        name: '/test-slack-fwd',
        url: 'https://hooks.slack.com/test',
        gateways_event_source_locations: ['gw1'],
        runner_type: 'gateway'
      },
      expected_outputs: [:id, :name]
  end

  describe 'akeyless_rotated_secret_aws' do
    it_behaves_like 'a pangea resource',
      resource_type: :akeyless_rotated_secret_aws,
      provider: Pangea::Resources::Akeyless,
      required_attrs: { name: '/test-rotated', target_name: '/target', rotator_type: 'api-key' },
      expected_outputs: [:id, :name]
  end
end
