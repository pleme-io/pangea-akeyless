# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_producer_redshift/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayProducerRedshift
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_producer_redshift,
      attributes_class: Akeyless::Types::GatewayProducerRedshiftAttributes,
      outputs: { id: :id },
      map: [:name],
      map_present: [:target_name, :user_ttl, :producer_encryption_key_name,
                    :redshift_db_name, :redshift_username, :redshift_password, :redshift_host,
                    :redshift_port, :creation_statements] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessGatewayProducerRedshift
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
