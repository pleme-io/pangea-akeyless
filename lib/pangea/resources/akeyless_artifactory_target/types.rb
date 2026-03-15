# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class ArtifactoryTargetAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :base_url, T::String
    attribute :artifactory_admin_name, T::String
    attribute? :artifactory_admin_pwd, T::String.optional
    attribute? :key, T::String.optional
    attribute? :description, T::String.optional
  end
end
