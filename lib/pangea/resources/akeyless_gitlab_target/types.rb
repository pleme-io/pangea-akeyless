# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GitlabTargetAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :gitlab_access_token, T::String.optional
    attribute? :gitlab_certificate, T::String.optional
    attribute :gitlab_url, T::String.default('https://gitlab.com/')
    attribute? :key, T::String.optional
    attribute? :description, T::String.optional
  end
end
