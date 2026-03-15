# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class AuthMethodAzureAdAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :bound_tenant_id, T::String
    attribute :access_expires, T::Integer.default(0)
    attribute :bound_ips, T::Array.of(T::String).default([].freeze)
    attribute :force_sub_claims, T::Bool.default(false)
    attribute :jwt_ttl, T::Integer.default(0)
    attribute? :issuer, T::String.optional
    attribute? :jwks_uri, T::String.optional
    attribute :audience, T::String.default("https://management.azure.com/")
    attribute :bound_spid, T::Array.of(T::String).default([].freeze)
    attribute :bound_group_id, T::Array.of(T::String).default([].freeze)
    attribute :bound_sub_id, T::Array.of(T::String).default([].freeze)
    attribute :bound_rg_id, T::Array.of(T::String).default([].freeze)
    attribute :bound_providers, T::Array.of(T::String).default([].freeze)
    attribute :bound_resource_types, T::Array.of(T::String).default([].freeze)
    attribute :bound_resource_names, T::Array.of(T::String).default([].freeze)
    attribute :bound_resource_id, T::Array.of(T::String).default([].freeze)
    attribute :audit_logs_claims, T::Array.of(T::String).default([].freeze)
    attribute? :delete_protection, T::String.optional
  end
end
