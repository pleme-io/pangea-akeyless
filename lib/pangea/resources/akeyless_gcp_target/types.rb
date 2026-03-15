# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GcpTargetAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :gcp_sa_email, T::String.optional
    attribute? :gcp_key_data, T::String.optional
    attribute :use_gw_cloud_identity, T::Bool.default(false)
    attribute? :key, T::String.optional
    attribute? :description, T::String.optional
  end
end
