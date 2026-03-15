# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class AuthMethodOauth2Attributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :unique_identifier, T::String
    attribute :access_expires, T::Integer.default(0)
    attribute :bound_ips, T::Array.of(T::String).default([].freeze)
    attribute :force_sub_claims, T::Bool.default(false)
    attribute :jwt_ttl, T::Integer.default(0)
    attribute? :jwks_uri, T::String.optional
    attribute? :jwks_json_data, T::String.optional
    attribute :bound_client_ids, T::Array.of(T::String).default([].freeze)
    attribute? :issuer, T::String.optional
    attribute? :audience, T::String.optional
    attribute :audit_logs_claims, T::Array.of(T::String).default([].freeze)
    attribute? :delete_protection, T::String.optional
    attribute? :gateway_url, T::String.optional
  end
end
