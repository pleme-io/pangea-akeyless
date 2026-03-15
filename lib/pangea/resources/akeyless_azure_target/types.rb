# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class AzureTargetAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :client_id, T::String.optional
    attribute? :tenant_id, T::String.optional
    attribute? :client_secret, T::String.optional
    attribute :use_gw_cloud_identity, T::Bool.default(false)
    attribute? :key, T::String.optional
    attribute? :description, T::String.optional
    attribute? :resource_group_name, T::String.optional
    attribute? :resource_name_, T::String.optional
    attribute? :subscription_id, T::String.optional
  end
end
