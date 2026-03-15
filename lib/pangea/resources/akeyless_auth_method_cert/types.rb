# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class AuthMethodCertAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :unique_identifier, T::String
    attribute :access_expires, T::Integer.default(0)
    attribute :bound_ips, T::Array.of(T::String).default([].freeze)
    attribute :force_sub_claims, T::Bool.default(false)
    attribute :jwt_ttl, T::Integer.default(0)
    attribute? :certificate_data, T::String.optional
    attribute :bound_common_names, T::Array.of(T::String).default([].freeze)
    attribute :bound_dns_sans, T::Array.of(T::String).default([].freeze)
    attribute :bound_email_sans, T::Array.of(T::String).default([].freeze)
    attribute :bound_uri_sans, T::Array.of(T::String).default([].freeze)
    attribute :bound_organizational_units, T::Array.of(T::String).default([].freeze)
    attribute :bound_extensions, T::Array.of(T::String).default([].freeze)
    attribute :revoked_cert_ids, T::Array.of(T::String).default([].freeze)
    attribute :audit_logs_claims, T::Array.of(T::String).default([].freeze)
    attribute? :delete_protection, T::String.optional
  end
end
