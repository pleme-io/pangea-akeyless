# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Pangea::Resources::Akeyless::Types do
  let(:t) { Pangea::Resources::Akeyless::Types }

  describe 'ClassicKeyAlgorithm' do
    %w[AES128GCM AES256GCM AES128SIV AES256SIV AES128CBC AES256CBC
       RSA1024 RSA2048 RSA3072 RSA4096 EC256 EC384 GPG].each do |alg|
      it "accepts #{alg}" do
        expect(t::ClassicKeyAlgorithm[alg]).to eq(alg)
      end
    end

    it 'rejects invalid algorithm' do
      expect { t::ClassicKeyAlgorithm['INVALID'] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects empty string' do
      expect { t::ClassicKeyAlgorithm[''] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects lowercase variant' do
      expect { t::ClassicKeyAlgorithm['aes128gcm'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'DfcKeyAlgorithm' do
    %w[AES128GCM AES256GCM AES128SIV AES256SIV AES128CBC AES256CBC
       RSA1024 RSA2048 RSA3072 RSA4096].each do |alg|
      it "accepts #{alg}" do
        expect(t::DfcKeyAlgorithm[alg]).to eq(alg)
      end
    end

    it 'rejects EC256 (not valid for DFC keys)' do
      expect { t::DfcKeyAlgorithm['EC256'] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects GPG (not valid for DFC keys)' do
      expect { t::DfcKeyAlgorithm['GPG'] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects EC384 (not valid for DFC keys)' do
      expect { t::DfcKeyAlgorithm['EC384'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'DbType' do
    %w[mysql mssql postgres mongodb snowflake oracle cassandra redshift].each do |db|
      it "accepts #{db}" do
        expect(t::DbType[db]).to eq(db)
      end
    end

    it 'rejects unknown database type' do
      expect { t::DbType['sqlite'] }.to raise_error(Dry::Types::ConstraintError)
    end

    it 'rejects uppercase variant' do
      expect { t::DbType['MySQL'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'CertificateFormat' do
    %w[pem der cer crt pfx p12].each do |fmt|
      it "accepts #{fmt}" do
        expect(t::CertificateFormat[fmt]).to eq(fmt)
      end
    end

    it 'rejects unknown format' do
      expect { t::CertificateFormat['jks'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'StaticSecretType' do
    it 'accepts generic' do
      expect(t::StaticSecretType['generic']).to eq('generic')
    end

    it 'accepts password' do
      expect(t::StaticSecretType['password']).to eq('password')
    end

    it 'defaults to generic' do
      expect(t::StaticSecretType[Dry::Types::Undefined]).to eq('generic')
    end

    it 'rejects invalid type' do
      expect { t::StaticSecretType['token'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe 'StaticSecretFormat' do
    it 'accepts text' do
      expect(t::StaticSecretFormat['text']).to eq('text')
    end

    it 'accepts json' do
      expect(t::StaticSecretFormat['json']).to eq('json')
    end

    it 'accepts base64' do
      expect(t::StaticSecretFormat['base64']).to eq('base64')
    end

    it 'defaults to text' do
      expect(t::StaticSecretFormat[Dry::Types::Undefined]).to eq('text')
    end

    it 'rejects invalid format' do
      expect { t::StaticSecretFormat['yaml'] }.to raise_error(Dry::Types::ConstraintError)
    end
  end
end
