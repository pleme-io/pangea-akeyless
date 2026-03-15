# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class K8sTargetAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :k8s_cluster_endpoint, T::String
    attribute :k8s_cluster_ca_cert, T::String
    attribute :k8s_cluster_token, T::String
    attribute? :key, T::String.optional
    attribute? :description, T::String.optional
  end
end
