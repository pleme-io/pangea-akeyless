# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class AuthDataAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :access_id, T::String
    attribute? :access_key, T::String.optional
    attribute :access_type, T::String.default("api_key")
    attribute? :admin_email, T::String.optional
    attribute? :admin_password, T::String.optional
  end
end
