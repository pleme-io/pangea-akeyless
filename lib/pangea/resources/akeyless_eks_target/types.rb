# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class EksTargetAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :eks_cluster_name, T::String
    attribute :eks_cluster_endpoint, T::String
    attribute :eks_cluster_ca_cert, T::String
    attribute :eks_access_key_id, T::String
    attribute? :eks_secret_access_key, T::String.optional
    attribute :eks_region, T::String.default('us-east-2')
    attribute? :key, T::String.optional
    attribute? :description, T::String.optional
    attribute :use_gw_cloud_identity, T::Bool.default(false)
  end
end
