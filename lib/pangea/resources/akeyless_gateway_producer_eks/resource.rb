# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_producer_eks/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayProducerEks
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_producer_eks,
      attributes_class: Akeyless::Types::GatewayProducerEksAttributes,
      outputs: { id: :id },
      map: [:name],
      map_present: [:target_name, :user_ttl, :producer_encryption_key_name,
                    :eks_cluster_name, :eks_cluster_endpoint, :eks_cluster_ca_cert,
                    :eks_access_key_id, :eks_secret_access_key, :eks_region] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessGatewayProducerEks
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
