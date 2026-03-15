# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class EventForwarderEmailAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :description, T::String.optional
    attribute :event_types, T::Array.of(T::String).default([].freeze)
    attribute? :email_to, T::String.optional
    attribute :runner_type, T::String.default('service')
  end
end
