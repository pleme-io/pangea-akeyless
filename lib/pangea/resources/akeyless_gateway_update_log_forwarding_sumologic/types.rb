# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayUpdateLogForwardingSumologicAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :enable, T::String.default('true')
    attribute? :output_format, T::String.optional
    attribute? :pull_interval, T::String.optional
    attribute? :sumologic_url, T::String.optional
    attribute? :host, T::String.optional
  end
end
