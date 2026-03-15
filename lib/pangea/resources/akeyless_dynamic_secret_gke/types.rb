# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class DynamicSecretGkeAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :target_name, T::String.optional
    attribute? :gke_cluster_endpoint, T::String.optional
    attribute? :gke_cluster_ca_cert, T::String.optional
    attribute? :gke_account_key, T::String.optional
    attribute? :gke_cluster_name, T::String.optional
    attribute? :gke_service_account_email, T::String.optional
    attribute :user_ttl, T::String.default('60m')
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute? :encryption_key_name, T::String.optional
  end
end
