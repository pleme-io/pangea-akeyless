# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_update_log_forwarding_logz_io/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayUpdateLogForwardingLogzIo
    def akeyless_gateway_update_log_forwarding_logz_io(name, attributes = {})
      attrs = Akeyless::Types::GatewayUpdateLogForwardingLogzIoAttributes.new(attributes)
      resource(:akeyless_gateway_update_log_forwarding_logz_io, name) do
        enable attrs.enable if attrs.enable
        output_format attrs.output_format if attrs.output_format
        pull_interval attrs.pull_interval if attrs.pull_interval
        logz_io_token attrs.logz_io_token if attrs.logz_io_token
        protocol attrs.protocol if attrs.protocol
      end
      ResourceReference.new(
        type: "akeyless_gateway_update_log_forwarding_logz_io",
        name: name,
        resource_attributes: attrs.to_h,
        outputs: { id: "${akeyless_gateway_update_log_forwarding_logz_io.#{name}.id}" }
      )
    end
  end
  module Akeyless
    include AkeylessGatewayUpdateLogForwardingLogzIo
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
