# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayUpdateLogForwardingSyslogAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :enable, T::String.default('true')
    attribute? :output_format, T::String.optional
    attribute? :pull_interval, T::String.optional
    attribute? :target_syslog_host, T::String.optional
    attribute :target_syslog_port, T::String.default('514')
    attribute :target_syslog_protocol, T::String.default('tcp')
    attribute? :target_syslog_tag, T::String.optional
    attribute? :formatter, T::String.optional
    attribute? :tls_certificate, T::String.optional
  end
end
