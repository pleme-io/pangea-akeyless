# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_update_log_forwarding_google_chronicle/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayUpdateLogForwardingGoogleChronicle
    def akeyless_gateway_update_log_forwarding_google_chronicle(name, attributes = {})
      attrs = Akeyless::Types::GatewayUpdateLogForwardingGoogleChronicleAttributes.new(attributes)
      resource(:akeyless_gateway_update_log_forwarding_google_chronicle, name) do
        enable attrs.enable if attrs.enable
        output_format attrs.output_format if attrs.output_format
        pull_interval attrs.pull_interval if attrs.pull_interval
        customer_id attrs.customer_id if attrs.customer_id
        region attrs.region if attrs.region
        log_type attrs.log_type if attrs.log_type
        gcp_key attrs.gcp_key if attrs.gcp_key
      end
      ResourceReference.new(
        type: "akeyless_gateway_update_log_forwarding_google_chronicle",
        name: name,
        resource_attributes: attrs.to_h,
        outputs: { id: "${akeyless_gateway_update_log_forwarding_google_chronicle.#{name}.id}" }
      )
    end
  end
  module Akeyless
    include AkeylessGatewayUpdateLogForwardingGoogleChronicle
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
