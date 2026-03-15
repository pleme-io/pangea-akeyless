# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class DynamicSecretGitlabAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :target_name, T::String.optional
    attribute? :gitlab_access_token, T::String.optional
    attribute? :gitlab_certificate, T::String.optional
    attribute? :gitlab_url, T::String.optional
    attribute :gitlab_access_type, T::String.default('token')
    attribute? :gitlab_role, T::String.optional
    attribute? :gitlab_token_scopes, T::String.optional
    attribute :user_ttl, T::String.default('60m')
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute? :encryption_key_name, T::String.optional
  end
end
