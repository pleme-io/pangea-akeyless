# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayUpdateLogForwardingDatadogAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute? :enable, T::String.optional.default("true")
    attribute? :output_format, T::String.optional
    attribute? :pull_interval, T::String.optional
    attribute? :host, T::String.optional
    attribute? :api_key, T::String.optional
    attribute :log_service, T::String.default('use-existing')
    attribute :log_source, T::String.default('use-existing')
  end
end
