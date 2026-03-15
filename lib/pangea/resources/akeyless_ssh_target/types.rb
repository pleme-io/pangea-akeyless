# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class SshTargetAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :host, T::String.optional
    attribute :port, T::String.default('22')
    attribute? :ssh_username, T::String.optional
    attribute? :ssh_password, T::String.optional
    attribute? :private_key, T::String.optional
    attribute? :private_key_password, T::String.optional
    attribute? :key, T::String.optional
    attribute? :description, T::String.optional
  end
end
