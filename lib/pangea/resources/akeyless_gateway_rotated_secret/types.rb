# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayRotatedSecretAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :target_name, T::String
    attribute :rotator_type, T::String
    attribute? :auto_rotate, T::String.optional.default('false')
    attribute? :rotation_interval, T::String.optional
    attribute? :rotation_hour, T::Integer.optional
    attribute? :rotated_username, T::String.optional
    attribute? :rotated_password, T::String.optional
    attribute? :key, T::String.optional
  end
end
