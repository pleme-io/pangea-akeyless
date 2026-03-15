# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_producer_cassandra/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayProducerCassandra
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_producer_cassandra,
      attributes_class: Akeyless::Types::GatewayProducerCassandraAttributes,
      outputs: { id: :id },
      map: [:name],
      map_present: [:target_name, :user_ttl, :producer_encryption_key_name,
                    :cassandra_hosts, :cassandra_port, :cassandra_username, :cassandra_password,
                    :cassandra_creation_statements] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessGatewayProducerCassandra
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
