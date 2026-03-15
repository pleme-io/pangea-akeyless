# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class AuthMethodAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :bound_ips, T::Array.of(T::String).default([].freeze)
    attribute :access_expires, T::Integer.default(0)
    attribute :force_sub_claims, T::Bool.default(false)
    attribute :jwt_ttl, T::Integer.default(0)
    attribute? :delete_protection, T::String.optional
  end
end
