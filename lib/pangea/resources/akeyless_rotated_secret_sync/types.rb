# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class RotatedSecretSyncAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :target_name, T::String
    attribute? :description, T::String.optional
    attribute :tags, T::Array.of(T::String).default([].freeze)
  end
end
