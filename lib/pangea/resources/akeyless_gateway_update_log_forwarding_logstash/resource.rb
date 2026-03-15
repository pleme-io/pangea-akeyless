# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_update_log_forwarding_logstash/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayUpdateLogForwardingLogstash
    def akeyless_gateway_update_log_forwarding_logstash(name, attributes = {})
      attrs = Akeyless::Types::GatewayUpdateLogForwardingLogstashAttributes.new(attributes)
      resource(:akeyless_gateway_update_log_forwarding_logstash, name) do
        enable attrs.enable if attrs.enable
        output_format attrs.output_format if attrs.output_format
        pull_interval attrs.pull_interval if attrs.pull_interval
        dns attrs.dns if attrs.dns
        protocol attrs.protocol if attrs.protocol
        tls_certificate attrs.tls_certificate if attrs.tls_certificate
      end
      ResourceReference.new(
        type: "akeyless_gateway_update_log_forwarding_logstash",
        name: name,
        resource_attributes: attrs.to_h,
        outputs: { id: "${akeyless_gateway_update_log_forwarding_logstash.#{name}.id}" }
      )
    end
  end
  module Akeyless
    include AkeylessGatewayUpdateLogForwardingLogstash
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
