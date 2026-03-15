# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GithubTargetAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :github_app_id, T::Integer.optional
    attribute? :github_app_private_key, T::String.optional
    attribute :github_base_url, T::String.default('https://api.github.com/')
    attribute? :key, T::String.optional
    attribute? :description, T::String.optional
  end
end
