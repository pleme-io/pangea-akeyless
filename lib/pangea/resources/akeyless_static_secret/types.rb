# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class StaticSecretAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :path, T::String
    attribute :type, StaticSecretType
    attribute? :value, T::String.optional
    attribute :format, StaticSecretFormat
    attribute? :multiline_value, T::Bool.optional
    attribute? :description, T::String.optional
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute :inject_url, T::Array.of(T::String).default([].freeze)
    attribute? :password, T::String.optional
    attribute? :username, T::String.optional
    attribute :custom_field, T::Hash.map(T::String, T::String).default({}.freeze)
    attribute? :keep_prev_version, T::String.optional
    attribute? :protection_key, T::String.optional
    attribute? :delete_protection, T::String.optional
    attribute? :secure_access_enable, T::String.optional
    attribute? :secure_access_ssh_creds, T::String.optional
    attribute? :secure_access_url, T::String.optional
    attribute? :secure_access_web_browsing, T::Bool.optional
    attribute? :secure_access_bastion_issuer, T::String.optional
    attribute :secure_access_host, T::Array.of(T::String).default([].freeze)
    attribute? :secure_access_ssh_user, T::String.optional
    attribute? :secure_access_web, T::Bool.optional
    attribute :ignore_cache, T::String.default("false")
  end
end
