# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayProducerGithubAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :target_name, T::String.optional
    attribute :user_ttl, T::String.default('60m')
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute? :producer_encryption_key_name, T::String.optional
    attribute? :github_app_id, T::Integer.optional
    attribute? :github_app_private_key, T::String.optional
    attribute? :github_base_url, T::String.optional
    attribute? :installation_id, T::Integer.optional
    attribute? :installation_organization, T::String.optional
    attribute? :token_permissions, T::String.optional
    attribute? :token_repositories, T::String.optional
  end
end
