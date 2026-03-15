# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/akeyless_classic_key/types'

RSpec.describe Pangea::Resources::Akeyless::Types::ClassicKeyAttributes do
  describe 'required attributes' do
    it 'requires name and alg' do
      expect { described_class.new({}) }.to raise_error(Dry::Struct::Error, /name/)
    end

    it 'requires alg' do
      expect { described_class.new(name: '/key') }.to raise_error(Dry::Struct::Error, /alg/)
    end
  end

  describe 'algorithm constraints' do
    it 'accepts valid AES algorithm' do
      attrs = described_class.new(name: '/key', alg: 'AES256GCM')
      expect(attrs.alg).to eq('AES256GCM')
    end

    it 'accepts valid RSA algorithm' do
      attrs = described_class.new(name: '/key', alg: 'RSA4096')
      expect(attrs.alg).to eq('RSA4096')
    end

    it 'accepts EC256' do
      attrs = described_class.new(name: '/key', alg: 'EC256')
      expect(attrs.alg).to eq('EC256')
    end

    it 'accepts GPG' do
      attrs = described_class.new(name: '/key', alg: 'GPG')
      expect(attrs.alg).to eq('GPG')
    end

    it 'rejects invalid algorithm' do
      expect { described_class.new(name: '/key', alg: 'INVALID') }
        .to raise_error(Dry::Struct::Error)
    end

    it 'rejects empty algorithm' do
      expect { described_class.new(name: '/key', alg: '') }
        .to raise_error(Dry::Struct::Error)
    end
  end

  describe 'defaults' do
    let(:attrs) { described_class.new(name: '/key', alg: 'AES256GCM') }

    it 'defaults certificate_format to pem' do
      expect(attrs.certificate_format).to eq('pem')
    end

    it 'defaults auto_rotate to false' do
      expect(attrs.auto_rotate).to eq('false')
    end

    it 'defaults rotation_interval to 90' do
      expect(attrs.rotation_interval).to eq('90')
    end

    it 'defaults generate_self_signed_certificate to false' do
      expect(attrs.generate_self_signed_certificate).to be false
    end

    it 'defaults tags to empty array' do
      expect(attrs.tags).to eq([])
    end
  end
end
