# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Edge cases and error handling' do
  include Pangea::Testing::SynthesisTestHelpers

  let(:synth) { create_synthesizer }

  before { synth.extend(Pangea::Resources::Akeyless) }

  describe 'empty and boundary inputs' do
    it 'accepts empty string for name (no path constraint at struct level)' do
      ref = synth.akeyless_folder(:empty_name, name: '')
      expect(ref.type).to eq('akeyless_folder')
    end

    it 'accepts very long name strings' do
      long_name = '/' + ('a' * 2000)
      ref = synth.akeyless_folder(:long_name, name: long_name)
      expect(ref.resource_attributes[:name]).to eq(long_name)
    end

    it 'accepts unicode in name' do
      ref = synth.akeyless_folder(:unicode, name: '/フォルダ/日本語')
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_folder', 'unicode')
      expect(config['name']).to eq('/フォルダ/日本語')
    end

    it 'passes through empty tags array via map_present' do
      ref = synth.akeyless_folder(:empty_tags, name: '/folder', tags: [])
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_folder', 'empty_tags')
      # Empty array is truthy in Ruby, so map_present includes it.
      # This means empty arrays will generate `tags = []` in Terraform.
      expect(config['tags']).to eq([])
    end

    it 'handles empty string in tags array' do
      ref = synth.akeyless_folder(:empty_tag, name: '/folder', tags: [''])
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_folder', 'empty_tag')
      expect(config['tags']).to eq([''])
    end
  end

  describe 'boolean nil vs false distinction (map_bool)' do
    it 'omits delete_protection when nil' do
      synth.akeyless_folder(:nil_bool, name: '/folder')
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_folder', 'nil_bool')
      expect(config).not_to have_key('delete_protection')
    end

    it 'includes delete_protection when false' do
      synth.akeyless_folder(:false_bool, name: '/folder', delete_protection: false)
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_folder', 'false_bool')
      expect(config['delete_protection']).to eq(false)
    end

    it 'includes delete_protection when true' do
      synth.akeyless_folder(:true_bool, name: '/folder', delete_protection: true)
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_folder', 'true_bool')
      expect(config['delete_protection']).to eq(true)
    end
  end

  describe 'type coercion via transform_keys' do
    it 'coerces string keys to symbol keys for attributes' do
      ref = synth.akeyless_folder(:coerced,
        'name' => '/folder',
        'description' => 'coerced desc'
      )
      result = normalize_synthesis(synth.synthesis)
      config = result.dig('resource', 'akeyless_folder', 'coerced')
      expect(config['name']).to eq('/folder')
      expect(config['description']).to eq('coerced desc')
    end
  end

  describe 'missing required attributes' do
    it 'raises Dry::Struct::Error for missing name in folder' do
      expect {
        synth.akeyless_folder(:no_name, {})
      }.to raise_error(Dry::Struct::Error)
    end

    it 'raises Dry::Struct::Error for missing required aws target attrs' do
      expect {
        synth.akeyless_target_aws(:incomplete, name: '/target')
      }.to raise_error(Dry::Struct::Error)
    end

    it 'raises Dry::Struct::Error for missing value in static secret' do
      expect {
        synth.akeyless_static_secret(:no_val, name: '/secret')
      }.to raise_error(Dry::Struct::Error)
    end
  end

  describe 'invalid attribute types' do
    it 'rejects integer where string expected for name' do
      expect {
        synth.akeyless_folder(:bad_type, name: 42)
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects string where boolean expected' do
      expect {
        synth.akeyless_folder(:bad_bool, name: '/f', delete_protection: 'true')
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects string where array expected for tags' do
      expect {
        synth.akeyless_folder(:bad_tags, name: '/f', tags: 'not-an-array')
      }.to raise_error(Dry::Struct::Error)
    end

    it 'rejects array of integers where array of strings expected' do
      expect {
        synth.akeyless_folder(:bad_tag_types, name: '/f', tags: [1, 2, 3])
      }.to raise_error(Dry::Struct::Error)
    end
  end

  describe 'unknown attributes' do
    it 'silently ignores unknown attributes (Dry::Struct default behavior)' do
      # Dry::Struct ignores extra keys by default with transform_keys.
      # This means typos in attribute names will NOT raise errors, which
      # could lead to silent misconfiguration.
      ref = synth.akeyless_folder(:unknown, name: '/f', nonexistent_field: 'val')
      expect(ref.type).to eq('akeyless_folder')
      expect(ref.resource_attributes).not_to have_key(:nonexistent_field)
    end
  end

  describe 'special characters in resource names' do
    it 'handles hyphens in resource name symbols' do
      ref = synth.akeyless_folder(:"my-folder", name: '/folder')
      expect(ref.outputs[:id]).to eq('${akeyless_folder.my-folder.id}')
    end

    it 'handles string resource names' do
      ref = synth.akeyless_folder('my_folder', name: '/folder')
      result = normalize_synthesis(synth.synthesis)
      expect(result.dig('resource', 'akeyless_folder', 'my_folder')).not_to be_nil
    end
  end
end
