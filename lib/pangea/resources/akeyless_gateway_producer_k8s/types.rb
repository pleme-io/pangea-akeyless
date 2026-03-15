# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayProducerK8sAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :target_name, T::String.optional
    attribute :user_ttl, T::String.default('60m')
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute? :producer_encryption_key_name, T::String.optional
    attribute? :k8s_cluster_endpoint, T::String.optional
    attribute? :k8s_cluster_ca_cert, T::String.optional
    attribute? :k8s_cluster_token, T::String.optional
    attribute? :k8s_namespace, T::String.optional
    attribute? :k8s_service_account, T::String.optional
    attribute? :k8s_allowed_namespaces, T::String.optional
  end
end
