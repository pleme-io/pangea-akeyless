# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_producer_oracle/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayProducerOracle
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_producer_oracle,
      attributes_class: Akeyless::Types::GatewayProducerOracleAttributes,
      outputs: { id: :id },
      map: [:name],
      map_present: [:target_name, :user_ttl, :producer_encryption_key_name,
                    :oracle_host, :oracle_port, :oracle_service_name, :oracle_username,
                    :oracle_password, :oracle_creation_statements, :oracle_revocation_statements] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessGatewayProducerOracle
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
