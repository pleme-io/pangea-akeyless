# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class TokenizerAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :template_type, T::String
    attribute? :description, T::String.optional
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute? :delete_protection, T::String.optional
  end
end
