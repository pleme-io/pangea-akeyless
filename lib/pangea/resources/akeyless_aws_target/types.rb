# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class AwsTargetAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :access_key_id, T::String
    attribute? :access_key, T::String.optional
    attribute? :session_token, T::String.optional
    attribute :region, T::String.default('us-east-2')
    attribute :use_gw_cloud_identity, T::Bool.default(false)
    attribute? :key, T::String.optional
    attribute? :description, T::String.optional
  end
end
