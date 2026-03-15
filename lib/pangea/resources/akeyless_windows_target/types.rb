# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class WindowsTargetAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :hostname, T::String
    attribute :username, T::String
    attribute? :password, T::String.optional
    attribute? :domain, T::String.optional
    attribute? :key, T::String.optional
    attribute? :description, T::String.optional
    attribute :use_tls, T::String.default('true')
    attribute :port, T::String.default('5986')
  end
end
