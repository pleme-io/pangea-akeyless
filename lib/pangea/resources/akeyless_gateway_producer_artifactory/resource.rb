# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_producer_artifactory/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayProducerArtifactory
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_producer_artifactory,
      attributes_class: Akeyless::Types::GatewayProducerArtifactoryAttributes,
      outputs: { id: :id },
      map: [:name],
      map_present: [:target_name, :user_ttl, :producer_encryption_key_name,
                    :artifactory_token_scope, :artifactory_token_audience, :base_url] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessGatewayProducerArtifactory
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
