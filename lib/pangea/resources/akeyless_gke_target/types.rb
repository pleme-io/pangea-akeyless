# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GkeTargetAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :gke_cluster_endpoint, T::String
    attribute :gke_cluster_ca_cert, T::String
    attribute? :gke_account_key, T::String.optional
    attribute :gke_cluster_name, T::String
    attribute? :gke_service_account_email, T::String.optional
    attribute :use_gw_cloud_identity, T::Bool.default(false)
    attribute? :key, T::String.optional
    attribute? :description, T::String.optional
  end
end
