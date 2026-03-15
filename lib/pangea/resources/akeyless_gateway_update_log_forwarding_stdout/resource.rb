# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_update_log_forwarding_stdout/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayUpdateLogForwardingStdout

    def akeyless_gateway_update_log_forwarding_stdout(name, attributes = {})
      attrs = Akeyless::Types::GatewayUpdateLogForwardingStdoutAttributes.new(attributes)
      resource(:akeyless_gateway_update_log_forwarding_stdout, name) do
        enable attrs.enable if attrs.enable
        output_format attrs.output_format if attrs.output_format
        pull_interval attrs.pull_interval if attrs.pull_interval
      end
      ResourceReference.new(type: 'akeyless_gateway_update_log_forwarding_stdout', name: name,
                            resource_attributes: attrs.to_h,
                            outputs: { id: "${akeyless_gateway_update_log_forwarding_stdout.#{name}.id}" })
    end
  end
  module Akeyless
    include AkeylessGatewayUpdateLogForwardingStdout
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
