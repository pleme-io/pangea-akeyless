# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class AuthMethodSamlAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :unique_identifier, T::String
    attribute :access_expires, T::Integer.default(0)
    attribute :bound_ips, T::Array.of(T::String).default([].freeze)
    attribute :force_sub_claims, T::Bool.default(false)
    attribute :jwt_ttl, T::Integer.default(0)
    attribute? :idp_metadata_url, T::String.optional
    attribute? :idp_metadata_xml_data, T::String.optional
    attribute :allowed_redirect_uri, T::Array.of(T::String).default([].freeze)
    attribute :audit_logs_claims, T::Array.of(T::String).default([].freeze)
    attribute? :delete_protection, T::String.optional
  end
end
