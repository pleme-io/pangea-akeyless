# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class DynamicSecretMysqlAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :target_name, T::String.optional
    attribute? :mysql_dbname, T::String.optional
    attribute? :mysql_username, T::String.optional
    attribute? :mysql_password, T::String.optional
    attribute? :mysql_host, T::String.optional
    attribute :mysql_port, T::String.default('3306')
    attribute? :mysql_creation_statements, T::String.optional
    attribute? :mysql_revocation_statements, T::String.optional
    attribute :user_ttl, T::String.default('60m')
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute? :encryption_key_name, T::String.optional
    attribute? :ssl, T::Bool.optional
    attribute? :ssl_certificate, T::String.optional
  end
end
