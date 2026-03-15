# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class DynamicSecretEksAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :target_name, T::String.optional
    attribute? :eks_cluster_name, T::String.optional
    attribute? :eks_cluster_endpoint, T::String.optional
    attribute? :eks_cluster_ca_cert, T::String.optional
    attribute? :eks_access_key_id, T::String.optional
    attribute? :eks_secret_access_key, T::String.optional
    attribute :eks_region, T::String.default('us-east-2')
    attribute :user_ttl, T::String.default('60m')
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute? :encryption_key_name, T::String.optional
  end
end
