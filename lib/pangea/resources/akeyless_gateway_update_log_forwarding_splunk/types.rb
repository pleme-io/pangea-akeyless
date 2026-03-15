# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayUpdateLogForwardingSplunkAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :enable, T::String.default('true')
    attribute? :output_format, T::String.optional
    attribute? :pull_interval, T::String.optional
    attribute? :splunk_url, T::String.optional
    attribute? :splunk_token, T::String.optional
    attribute? :source, T::String.optional
    attribute? :source_type, T::String.optional
    attribute? :index, T::String.optional
    attribute? :tls_certificate, T::String.optional
  end
end
