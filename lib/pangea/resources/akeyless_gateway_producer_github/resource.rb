# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_producer_github/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayProducerGithub
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_producer_github,
      attributes_class: Akeyless::Types::GatewayProducerGithubAttributes,
      outputs: { id: :id },
      map: [:name],
      map_present: [:target_name, :user_ttl, :producer_encryption_key_name,
                    :github_app_id, :github_app_private_key, :github_base_url,
                    :installation_id, :installation_organization, :token_permissions,
                    :token_repositories] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessGatewayProducerGithub
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
