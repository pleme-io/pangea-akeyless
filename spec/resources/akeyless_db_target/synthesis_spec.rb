# frozen_string_literal: true

require 'spec_helper'
require 'terraform-synthesizer'
require 'pangea/resources/akeyless_db_target/resource'

RSpec.describe 'akeyless_db_target synthesis' do
  let(:synthesizer) { TerraformSynthesizer.new }

  describe 'terraform synthesis' do
    it 'synthesizes PostgreSQL target' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_db_target(:postgres, {
          name: "/targets/postgres-prod",
          db_type: "postgres",
          host: "db.example.com",
          port: "5432",
          user_name: "admin",
          pwd: "secret",
          db_name: "mydb",
          ssl: true
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_db_target][:postgres]

      expect(resource[:name]).to eq("/targets/postgres-prod")
      expect(resource[:db_type]).to eq("postgres")
      expect(resource[:host]).to eq("db.example.com")
      expect(resource[:ssl]).to be true
    end

    it 'synthesizes MongoDB Atlas target' do
      synthesizer.instance_eval do
        extend Pangea::Resources::Akeyless
        akeyless_db_target(:mongo, {
          name: "/targets/mongo-atlas",
          db_type: "mongodb",
          mongodb_atlas: true,
          mongodb_atlas_project_id: "proj-123",
          mongodb_atlas_api_public_key: "pub-key",
          mongodb_atlas_api_private_key: "priv-key"
        })
      end

      result = synthesizer.synthesis
      resource = result[:resource][:akeyless_db_target][:mongo]

      expect(resource[:db_type]).to eq("mongodb")
      expect(resource[:mongodb_atlas]).to be true
    end
  end
end
