# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_update_log_forwarding_elasticsearch/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayUpdateLogForwardingElasticsearch
    def akeyless_gateway_update_log_forwarding_elasticsearch(name, attributes = {})
      attrs = Akeyless::Types::GatewayUpdateLogForwardingElasticsearchAttributes.new(attributes)
      resource(:akeyless_gateway_update_log_forwarding_elasticsearch, name) do
        enable attrs.enable if attrs.enable
        output_format attrs.output_format if attrs.output_format
        pull_interval attrs.pull_interval if attrs.pull_interval
        index attrs.index if attrs.index
        server_type attrs.server_type if attrs.server_type
        nodes attrs.nodes if attrs.nodes
        auth_type attrs.auth_type if attrs.auth_type
        elasticsearch_username attrs.elasticsearch_username if attrs.elasticsearch_username
        elasticsearch_password attrs.elasticsearch_password if attrs.elasticsearch_password
        api_key attrs.api_key if attrs.api_key
        cloud_id attrs.cloud_id if attrs.cloud_id
        tls_certificate attrs.tls_certificate if attrs.tls_certificate
      end
      ResourceReference.new(
        type: "akeyless_gateway_update_log_forwarding_elasticsearch",
        name: name,
        resource_attributes: attrs.to_h,
        outputs: { id: "${akeyless_gateway_update_log_forwarding_elasticsearch.#{name}.id}" }
      )
    end
  end
  module Akeyless
    include AkeylessGatewayUpdateLogForwardingElasticsearch
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
