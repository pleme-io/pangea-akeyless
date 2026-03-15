# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_producer_gke/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayProducerGke
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_producer_gke,
      attributes_class: Akeyless::Types::GatewayProducerGkeAttributes,
      outputs: { id: :id },
      map: [:name],
      map_present: [:target_name, :user_ttl, :producer_encryption_key_name,
                    :gke_cluster_endpoint, :gke_cluster_ca_cert, :gke_account_key,
                    :gke_cluster_name, :gke_service_account_email] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessGatewayProducerGke
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
