# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class AuthMethodUniversalIdentityAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :access_expires, T::Integer.default(0)
    attribute :bound_ips, T::Array.of(T::String).default([].freeze)
    attribute :force_sub_claims, T::Bool.default(false)
    attribute :jwt_ttl, T::Integer.default(0)
    attribute :deny_rotate, T::Bool.default(false)
    attribute :deny_inheritance, T::Bool.default(false)
    attribute :ttl, T::Integer.default(0)
    attribute :audit_logs_claims, T::Array.of(T::String).default([].freeze)
    attribute? :delete_protection, T::String.optional
  end
end
