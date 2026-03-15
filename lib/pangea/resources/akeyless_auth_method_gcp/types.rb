# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class AuthMethodGcpAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :type, T::String
    attribute :audience, T::String.default("akeyless.io")
    attribute :access_expires, T::Integer.default(0)
    attribute :bound_ips, T::Array.of(T::String).default([].freeze)
    attribute :force_sub_claims, T::Bool.default(false)
    attribute :jwt_ttl, T::Integer.default(0)
    attribute? :service_account_creds_data, T::String.optional
    attribute :bound_projects, T::Array.of(T::String).default([].freeze)
    attribute :bound_service_accounts, T::Array.of(T::String).default([].freeze)
    attribute :bound_zones, T::Array.of(T::String).default([].freeze)
    attribute :bound_regions, T::Array.of(T::String).default([].freeze)
    attribute :bound_labels, T::Array.of(T::String).default([].freeze)
    attribute :audit_logs_claims, T::Array.of(T::String).default([].freeze)
    attribute? :delete_protection, T::String.optional
  end
end
