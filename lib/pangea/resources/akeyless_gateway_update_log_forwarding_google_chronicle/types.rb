# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayUpdateLogForwardingGoogleChronicleAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute? :enable, T::String.optional.default("true")
    attribute? :output_format, T::String.optional
    attribute? :pull_interval, T::String.optional
    attribute? :customer_id, T::String.optional
    attribute? :region, T::String.optional
    attribute? :log_type, T::String.optional
    attribute? :gcp_key, T::String.optional
  end
end
