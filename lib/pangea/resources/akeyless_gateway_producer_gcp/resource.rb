# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_producer_gcp/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayProducerGcp
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_producer_gcp,
      attributes_class: Akeyless::Types::GatewayProducerGcpAttributes,
      outputs: { id: :id },
      map: [:name],
      map_present: [:target_name, :user_ttl, :producer_encryption_key_name,
                    :gcp_sa_email, :gcp_key_algo, :gcp_key_data, :service_account_type,
                    :role_binding] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessGatewayProducerGcp
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
