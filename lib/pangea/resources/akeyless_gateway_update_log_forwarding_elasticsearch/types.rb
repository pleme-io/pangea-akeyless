# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayUpdateLogForwardingElasticsearchAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute? :enable, T::String.optional.default("true")
    attribute? :output_format, T::String.optional
    attribute? :pull_interval, T::String.optional
    attribute? :index, T::String.optional
    attribute? :server_type, T::String.optional
    attribute? :nodes, T::String.optional
    attribute? :auth_type, T::String.optional
    attribute? :elasticsearch_username, T::String.optional
    attribute? :elasticsearch_password, T::String.optional
    attribute? :api_key, T::String.optional
    attribute? :cloud_id, T::String.optional
    attribute? :tls_certificate, T::String.optional
  end
end
