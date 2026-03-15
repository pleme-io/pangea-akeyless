# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class CertificateAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :certificate_data, T::String.optional
    attribute :format, T::String.default("pem")
    attribute? :key_data, T::String.optional
    attribute :expiration_event_in, T::Array.of(T::String).default([].freeze)
    attribute? :key, T::String.optional
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute? :description, T::String.optional
    attribute? :delete_protection, T::String.optional
  end
end
