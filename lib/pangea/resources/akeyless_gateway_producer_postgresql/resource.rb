# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_producer_postgresql/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayProducerPostgresql
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_producer_postgresql,
      attributes_class: Akeyless::Types::GatewayProducerPostgresqlAttributes,
      outputs: { id: :id },
      map: [:name],
      map_present: [:target_name, :user_ttl, :producer_encryption_key_name,
                    :postgresql_db_name, :postgresql_username, :postgresql_password, :postgresql_host,
                    :postgresql_port, :creation_statements, :revocation_statements] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessGatewayProducerPostgresql
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
