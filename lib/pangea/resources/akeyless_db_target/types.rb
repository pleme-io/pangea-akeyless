# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class DbTargetAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :db_type, T::DbType
    attribute? :user_name, T::String.optional
    attribute? :host, T::String.optional
    attribute? :pwd, T::String.optional
    attribute? :port, T::String.optional
    attribute? :db_name, T::String.optional
    attribute? :db_server_certificates, T::String.optional
    attribute? :db_server_name, T::String.optional
    attribute :ssl, T::Bool.default(false)
    attribute? :ssl_certificate, T::String.optional
    attribute? :snowflake_account, T::String.optional
    attribute :mongodb_atlas, T::Bool.default(false)
    attribute? :mongodb_default_auth_db, T::String.optional
    attribute? :mongodb_uri_options, T::String.optional
    attribute? :mongodb_atlas_project_id, T::String.optional
    attribute? :mongodb_atlas_api_public_key, T::String.optional
    attribute? :mongodb_atlas_api_private_key, T::String.optional
    attribute? :key, T::String.optional
    attribute? :description, T::String.optional
    attribute? :oracle_service_name, T::String.optional
  end
end
