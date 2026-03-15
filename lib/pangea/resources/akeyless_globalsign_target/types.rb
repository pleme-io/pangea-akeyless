# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GlobalsignTargetAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :username, T::String
    attribute? :password, T::String.optional
    attribute :contact_first_name, T::String
    attribute :contact_last_name, T::String
    attribute :contact_email, T::String
    attribute :contact_phone, T::String
    attribute :profile_id, T::String
    attribute? :key, T::String.optional
    attribute? :description, T::String.optional
  end
end
