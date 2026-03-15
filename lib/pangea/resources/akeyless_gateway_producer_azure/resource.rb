# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_producer_azure/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayProducerAzure
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_producer_azure,
      attributes_class: Akeyless::Types::GatewayProducerAzureAttributes,
      outputs: { id: :id },
      map: [:name],
      map_present: [:target_name, :user_ttl, :producer_encryption_key_name,
                    :azure_tenant_id, :azure_client_id, :azure_client_secret, :app_obj_id] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessGatewayProducerAzure
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
