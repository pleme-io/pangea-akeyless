# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayProducerCustomAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :create_sync_url, T::String
    attribute :revoke_sync_url, T::String
    attribute? :target_name, T::String.optional
    attribute :user_ttl, T::String.default('60m')
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute? :producer_encryption_key_name, T::String.optional
    attribute? :payload, T::String.optional
    attribute :timeout_sec, T::Integer.default(60)
    attribute :enable_admin_rotation, T::Bool.default(false)
  end
end
