# frozen_string_literal: true

require 'spec_helper'
require 'pangea/resources/akeyless_db_target/types'

RSpec.describe Pangea::Resources::Akeyless::Types::DbTargetAttributes do
  describe 'required attributes' do
    it 'requires name and db_type' do
      expect { described_class.new({}) }.to raise_error(Dry::Struct::Error)
    end

    it 'requires db_type' do
      expect { described_class.new(name: '/target') }.to raise_error(Dry::Struct::Error, /db_type/)
    end
  end

  describe 'db_type constraints' do
    %w[mysql mssql postgres mongodb snowflake oracle cassandra redshift].each do |db|
      it "accepts #{db}" do
        attrs = described_class.new(name: '/target', db_type: db)
        expect(attrs.db_type).to eq(db)
      end
    end

    it 'rejects invalid db_type' do
      expect { described_class.new(name: '/target', db_type: 'sqlite') }
        .to raise_error(Dry::Struct::Error)
    end
  end

  describe 'defaults' do
    let(:attrs) { described_class.new(name: '/target', db_type: 'postgres') }

    it 'defaults ssl to false' do
      expect(attrs.ssl).to be false
    end
  end

  describe 'optional attributes' do
    it 'accepts full PostgreSQL config' do
      attrs = described_class.new(
        name: '/target',
        db_type: 'postgres',
        host: 'db.example.com',
        port: '5432',
        user_name: 'admin',
        pwd: 'secret',
        db_name: 'mydb',
        ssl: true
      )
      expect(attrs.host).to eq('db.example.com')
      expect(attrs.ssl).to be true
    end

    it 'accepts MongoDB Atlas config' do
      attrs = described_class.new(
        name: '/target',
        db_type: 'mongodb',
        mongodb_atlas: true,
        mongodb_atlas_project_id: 'proj-123'
      )
      expect(attrs.mongodb_atlas).to be true
    end
  end
end
