# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_update_log_forwarding_sumologic/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayUpdateLogForwardingSumologic

    def akeyless_gateway_update_log_forwarding_sumologic(name, attributes = {})
      attrs = Akeyless::Types::GatewayUpdateLogForwardingSumologicAttributes.new(attributes)
      resource(:akeyless_gateway_update_log_forwarding_sumologic, name) do
        enable attrs.enable if attrs.enable
        output_format attrs.output_format if attrs.output_format
        pull_interval attrs.pull_interval if attrs.pull_interval
        sumologic_url attrs.sumologic_url if attrs.sumologic_url
        host attrs.host if attrs.host
      end
      ResourceReference.new(type: 'akeyless_gateway_update_log_forwarding_sumologic', name: name,
                            resource_attributes: attrs.to_h,
                            outputs: { id: "${akeyless_gateway_update_log_forwarding_sumologic.#{name}.id}" })
    end
  end
  module Akeyless
    include AkeylessGatewayUpdateLogForwardingSumologic
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
