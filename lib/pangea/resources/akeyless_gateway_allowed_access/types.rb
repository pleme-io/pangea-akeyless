# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayAllowedAccessAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :access_id, T::String
    attribute? :description, T::String.optional
    attribute :sub_claims, T::Hash.map(T::String, T::String).default({}.freeze)
    attribute? :permissions, T::String.optional
  end
end
