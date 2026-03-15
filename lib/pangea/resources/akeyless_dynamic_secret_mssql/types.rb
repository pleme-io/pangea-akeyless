# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class DynamicSecretMssqlAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :target_name, T::String.optional
    attribute? :mssql_dbname, T::String.optional
    attribute? :mssql_username, T::String.optional
    attribute? :mssql_password, T::String.optional
    attribute? :mssql_host, T::String.optional
    attribute :mssql_port, T::String.default('1433')
    attribute? :mssql_creation_statements, T::String.optional
    attribute? :mssql_revocation_statements, T::String.optional
    attribute :user_ttl, T::String.default('60m')
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute? :encryption_key_name, T::String.optional
  end
end
