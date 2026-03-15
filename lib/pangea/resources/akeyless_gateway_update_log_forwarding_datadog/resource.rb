# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_update_log_forwarding_datadog/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayUpdateLogForwardingDatadog
    def akeyless_gateway_update_log_forwarding_datadog(name, attributes = {})
      attrs = Akeyless::Types::GatewayUpdateLogForwardingDatadogAttributes.new(attributes)
      resource(:akeyless_gateway_update_log_forwarding_datadog, name) do
        enable attrs.enable if attrs.enable
        output_format attrs.output_format if attrs.output_format
        pull_interval attrs.pull_interval if attrs.pull_interval
        host attrs.host if attrs.host
        api_key attrs.api_key if attrs.api_key
        log_service attrs.log_service if attrs.log_service
        log_source attrs.log_source if attrs.log_source
      end
      ResourceReference.new(
        type: "akeyless_gateway_update_log_forwarding_datadog",
        name: name,
        resource_attributes: attrs.to_h,
        outputs: { id: "${akeyless_gateway_update_log_forwarding_datadog.#{name}.id}" }
      )
    end
  end
  module Akeyless
    include AkeylessGatewayUpdateLogForwardingDatadog
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
