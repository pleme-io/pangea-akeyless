# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class ItemsDataAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :path, T::String.default("/")
    attribute? :type, T::String.optional
    attribute? :filter, T::String.optional
    attribute? :pagination_token, T::String.optional
    attribute? :tag, T::String.optional
  end
end
