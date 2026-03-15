# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_producer_mssql/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayProducerMssql
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_producer_mssql,
      attributes_class: Akeyless::Types::GatewayProducerMssqlAttributes,
      outputs: { id: :id },
      map: [:name],
      map_present: [:target_name, :user_ttl, :producer_encryption_key_name,
                    :mssql_dbname, :mssql_username, :mssql_password, :mssql_host,
                    :mssql_port, :mssql_creation_statements, :mssql_revocation_statements] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessGatewayProducerMssql
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
