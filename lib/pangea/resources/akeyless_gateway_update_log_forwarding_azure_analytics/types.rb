# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayUpdateLogForwardingAzureAnalyticsAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute? :enable, T::String.optional.default("true")
    attribute? :output_format, T::String.optional
    attribute? :pull_interval, T::String.optional
    attribute? :workspace_id, T::String.optional
    attribute? :workspace_key, T::String.optional
  end
end
