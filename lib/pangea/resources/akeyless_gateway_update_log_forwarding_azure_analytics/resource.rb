# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_update_log_forwarding_azure_analytics/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayUpdateLogForwardingAzureAnalytics
    def akeyless_gateway_update_log_forwarding_azure_analytics(name, attributes = {})
      attrs = Akeyless::Types::GatewayUpdateLogForwardingAzureAnalyticsAttributes.new(attributes)
      resource(:akeyless_gateway_update_log_forwarding_azure_analytics, name) do
        enable attrs.enable if attrs.enable
        output_format attrs.output_format if attrs.output_format
        pull_interval attrs.pull_interval if attrs.pull_interval
        workspace_id attrs.workspace_id if attrs.workspace_id
        workspace_key attrs.workspace_key if attrs.workspace_key
      end
      ResourceReference.new(
        type: "akeyless_gateway_update_log_forwarding_azure_analytics",
        name: name,
        resource_attributes: attrs.to_h,
        outputs: { id: "${akeyless_gateway_update_log_forwarding_azure_analytics.#{name}.id}" }
      )
    end
  end
  module Akeyless
    include AkeylessGatewayUpdateLogForwardingAzureAnalytics
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
