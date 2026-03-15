# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class RotatedSecretAzureAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :target_name, T::String
    attribute? :description, T::String.optional
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute? :rotation_interval, T::String.optional
    attribute? :rotation_hour, T::Integer.optional
    attribute :rotator_type, T::String
    attribute? :auto_rotate, T::String.optional.default('false')
    attribute? :key, T::String.optional
    attribute? :rotated_username, T::String.optional
    attribute? :rotated_password, T::String.optional
    attribute :rotation_event_in, T::Array.of(T::String).default([].freeze)
    attribute? :delete_protection, T::String.optional
  end
end
