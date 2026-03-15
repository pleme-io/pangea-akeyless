# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_producer_mongo/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayProducerMongo
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_producer_mongo,
      attributes_class: Akeyless::Types::GatewayProducerMongoAttributes,
      outputs: { id: :id },
      map: [:name],
      map_present: [:target_name, :user_ttl, :producer_encryption_key_name,
                    :mongodb_host_port, :mongodb_name, :mongodb_server_uri, :mongodb_username,
                    :mongodb_password, :mongodb_default_auth_db, :mongodb_roles] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessGatewayProducerMongo
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
