# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayProducerRdpAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :target_name, T::String.optional
    attribute :user_ttl, T::String.default('60m')
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute? :producer_encryption_key_name, T::String.optional
    attribute? :rdp_admin_name, T::String.optional
    attribute? :rdp_admin_pwd, T::String.optional
    attribute? :rdp_host_name, T::String.optional
    attribute :rdp_host_port, T::String.default('3389')
    attribute? :rdp_user_groups, T::String.optional
  end
end
