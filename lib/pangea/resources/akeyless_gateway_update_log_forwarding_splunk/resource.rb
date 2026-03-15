# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_update_log_forwarding_splunk/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayUpdateLogForwardingSplunk

    def akeyless_gateway_update_log_forwarding_splunk(name, attributes = {})
      attrs = Akeyless::Types::GatewayUpdateLogForwardingSplunkAttributes.new(attributes)
      resource(:akeyless_gateway_update_log_forwarding_splunk, name) do
        enable attrs.enable if attrs.enable
        output_format attrs.output_format if attrs.output_format
        pull_interval attrs.pull_interval if attrs.pull_interval
        splunk_url attrs.splunk_url if attrs.splunk_url
        splunk_token attrs.splunk_token if attrs.splunk_token
        source attrs.source if attrs.source
        source_type attrs.source_type if attrs.source_type
        index attrs.index if attrs.index
        tls_certificate attrs.tls_certificate if attrs.tls_certificate
      end
      ResourceReference.new(type: 'akeyless_gateway_update_log_forwarding_splunk', name: name,
                            resource_attributes: attrs.to_h,
                            outputs: { id: "${akeyless_gateway_update_log_forwarding_splunk.#{name}.id}" })
    end
  end
  module Akeyless
    include AkeylessGatewayUpdateLogForwardingSplunk
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
