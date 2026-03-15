# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class AssociateRoleAuthMethodAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :role_name, T::String
    attribute :am_name, T::String
    attribute :sub_claims, T::Hash.map(T::String, T::String).default({}.freeze)
    attribute :case_sensitive, T::String.default("true")
  end
end
