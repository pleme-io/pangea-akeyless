# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_producer_mysql/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayProducerMysql
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_producer_mysql,
      attributes_class: Akeyless::Types::GatewayProducerMysqlAttributes,
      outputs: { id: :id },
      map: [:name],
      map_present: [:target_name, :user_ttl, :producer_encryption_key_name,
                    :mysql_dbname, :mysql_username, :mysql_password, :mysql_host,
                    :mysql_port, :mysql_creation_statements, :mysql_revocation_statements] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessGatewayProducerMysql
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
