# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class CsrDataAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :common_name, T::String
    attribute? :country, T::String.optional
    attribute? :organization, T::String.optional
    attribute? :dep, T::String.optional
    attribute? :city, T::String.optional
    attribute? :state, T::String.optional
    attribute? :alt_names, T::String.optional
    attribute :key_type, T::String.default("RSA2048")
    attribute? :uri_sans, T::String.optional
    attribute? :email_addresses, T::String.optional
    attribute? :generate_key, T::Bool.optional
  end
end
