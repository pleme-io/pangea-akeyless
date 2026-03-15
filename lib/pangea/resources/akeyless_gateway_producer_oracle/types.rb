# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayProducerOracleAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :target_name, T::String.optional
    attribute :user_ttl, T::String.default('60m')
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute? :producer_encryption_key_name, T::String.optional
    attribute? :oracle_host, T::String.optional
    attribute :oracle_port, T::String.default('1521')
    attribute? :oracle_service_name, T::String.optional
    attribute? :oracle_username, T::String.optional
    attribute? :oracle_password, T::String.optional
    attribute? :oracle_creation_statements, T::String.optional
    attribute? :oracle_revocation_statements, T::String.optional
  end
end
