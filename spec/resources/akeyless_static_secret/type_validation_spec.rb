# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/akeyless_static_secret/types'

RSpec.describe Pangea::Resources::Akeyless::Types::StaticSecretAttributes do
  describe 'required attributes' do
    it 'requires path' do
      expect { described_class.new({}) }.to raise_error(Dry::Struct::Error, /path/)
    end

    it 'accepts minimal attributes' do
      attrs = described_class.new(path: '/test')
      expect(attrs.path).to eq('/test')
    end
  end

  describe 'defaults' do
    let(:attrs) { described_class.new(path: '/test') }

    it 'defaults type to generic' do
      expect(attrs.type).to eq('generic')
    end

    it 'defaults format to text' do
      expect(attrs.format).to eq('text')
    end

    it 'defaults tags to empty array' do
      expect(attrs.tags).to eq([])
    end

    it 'defaults ignore_cache to false' do
      expect(attrs.ignore_cache).to eq('false')
    end
  end

  describe 'type constraints' do
    it 'rejects invalid secret type' do
      expect { described_class.new(path: '/test', type: 'invalid') }
        .to raise_error(Dry::Struct::Error)
    end

    it 'accepts generic type' do
      attrs = described_class.new(path: '/test', type: 'generic')
      expect(attrs.type).to eq('generic')
    end

    it 'accepts password type' do
      attrs = described_class.new(path: '/test', type: 'password')
      expect(attrs.type).to eq('password')
    end

    it 'rejects invalid format' do
      expect { described_class.new(path: '/test', format: 'xml') }
        .to raise_error(Dry::Struct::Error)
    end

    it 'accepts json format' do
      attrs = described_class.new(path: '/test', format: 'json')
      expect(attrs.format).to eq('json')
    end

    it 'accepts base64 format' do
      attrs = described_class.new(path: '/test', format: 'base64')
      expect(attrs.format).to eq('base64')
    end
  end

  describe 'optional attributes' do
    it 'allows nil value' do
      attrs = described_class.new(path: '/test')
      expect(attrs.value).to be_nil
    end

    it 'accepts value' do
      attrs = described_class.new(path: '/test', value: 'secret')
      expect(attrs.value).to eq('secret')
    end

    it 'accepts tags array' do
      attrs = described_class.new(path: '/test', tags: ['prod', 'db'])
      expect(attrs.tags).to eq(['prod', 'db'])
    end

    it 'accepts multiline_value boolean' do
      attrs = described_class.new(path: '/test', multiline_value: true)
      expect(attrs.multiline_value).to be true
    end
  end

  describe 'key coercion' do
    it 'accepts string keys' do
      attrs = described_class.new('path' => '/test', 'type' => 'password')
      expect(attrs.path).to eq('/test')
      expect(attrs.type).to eq('password')
    end
  end
end
