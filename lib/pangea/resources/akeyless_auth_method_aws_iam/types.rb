# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class AuthMethodAwsIamAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :bound_aws_account_id, T::Array.of(T::String)
    attribute :access_expires, T::Integer.default(0)
    attribute :bound_ips, T::Array.of(T::String).default([].freeze)
    attribute :force_sub_claims, T::Bool.default(false)
    attribute :jwt_ttl, T::Integer.default(0)
    attribute :sts_url, T::String.default("https://sts.amazonaws.com")
    attribute :bound_arn, T::Array.of(T::String).default([].freeze)
    attribute :bound_role_name, T::Array.of(T::String).default([].freeze)
    attribute :bound_role_id, T::Array.of(T::String).default([].freeze)
    attribute :bound_resource_id, T::Array.of(T::String).default([].freeze)
    attribute :bound_user_name, T::Array.of(T::String).default([].freeze)
    attribute :bound_user_id, T::Array.of(T::String).default([].freeze)
    attribute :audit_logs_claims, T::Array.of(T::String).default([].freeze)
    attribute? :delete_protection, T::String.optional
  end
end
