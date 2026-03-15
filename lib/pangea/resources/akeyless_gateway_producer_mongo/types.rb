# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayProducerMongoAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :target_name, T::String.optional
    attribute :user_ttl, T::String.default('60m')
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute? :producer_encryption_key_name, T::String.optional
    attribute? :mongodb_host_port, T::String.optional
    attribute? :mongodb_name, T::String.optional
    attribute? :mongodb_server_uri, T::String.optional
    attribute? :mongodb_username, T::String.optional
    attribute? :mongodb_password, T::String.optional
    attribute? :mongodb_default_auth_db, T::String.optional
    attribute? :mongodb_roles, T::String.optional
  end
end
