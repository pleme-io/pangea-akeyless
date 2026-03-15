# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class RabbitmqTargetAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :rabbitmq_server_uri, T::String
    attribute? :rabbitmq_server_user, T::String.optional
    attribute? :rabbitmq_server_password, T::String.optional
    attribute? :key, T::String.optional
    attribute? :description, T::String.optional
  end
end
