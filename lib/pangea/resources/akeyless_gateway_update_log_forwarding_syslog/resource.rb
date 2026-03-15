# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_update_log_forwarding_syslog/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayUpdateLogForwardingSyslog

    def akeyless_gateway_update_log_forwarding_syslog(name, attributes = {})
      attrs = Akeyless::Types::GatewayUpdateLogForwardingSyslogAttributes.new(attributes)
      resource(:akeyless_gateway_update_log_forwarding_syslog, name) do
        enable attrs.enable if attrs.enable
        output_format attrs.output_format if attrs.output_format
        pull_interval attrs.pull_interval if attrs.pull_interval
        target_syslog_host attrs.target_syslog_host if attrs.target_syslog_host
        target_syslog_port attrs.target_syslog_port if attrs.target_syslog_port
        target_syslog_protocol attrs.target_syslog_protocol if attrs.target_syslog_protocol
        target_syslog_tag attrs.target_syslog_tag if attrs.target_syslog_tag
        formatter attrs.formatter if attrs.formatter
        tls_certificate attrs.tls_certificate if attrs.tls_certificate
      end
      ResourceReference.new(type: 'akeyless_gateway_update_log_forwarding_syslog', name: name,
                            resource_attributes: attrs.to_h,
                            outputs: { id: "${akeyless_gateway_update_log_forwarding_syslog.#{name}.id}" })
    end
  end
  module Akeyless
    include AkeylessGatewayUpdateLogForwardingSyslog
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
