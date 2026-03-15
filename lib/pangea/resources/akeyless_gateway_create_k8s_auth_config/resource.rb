# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_create_k8s_auth_config/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayCreateK8sAuthConfig
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_create_k8s_auth_config,
      attributes_class: Akeyless::Types::GatewayCreateK8sAuthConfigAttributes,
      outputs: { id: :id },
      map: [:name, :access_id, :signing_key],
      map_present: [:config_encryption_key_name, :k8s_host, :k8s_ca_cert, :token_reviewer_jwt, :k8s_issuer],
      map_bool: [:disable_issuer_validation]
  end
  module Akeyless
    include AkeylessGatewayCreateK8sAuthConfig
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
