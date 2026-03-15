# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_producer_k8s/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayProducerK8s
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_producer_k8s,
      attributes_class: Akeyless::Types::GatewayProducerK8sAttributes,
      outputs: { id: :id },
      map: [:name],
      map_present: [:target_name, :user_ttl, :producer_encryption_key_name,
                    :k8s_cluster_endpoint, :k8s_cluster_ca_cert, :k8s_cluster_token,
                    :k8s_namespace, :k8s_service_account, :k8s_allowed_namespaces] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessGatewayProducerK8s
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
