# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_k8s_auth_config/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessK8sAuthConfig
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_k8s_auth_config,
      attributes_class: Akeyless::Types::K8sAuthConfigDataAttributes,
      outputs: {
        id: :id,
        k8s_host: :k8s_host,
        k8s_ca_cert: :k8s_ca_cert,
        k8s_issuer: :k8s_issuer,
        disable_issuer_validation: :disable_issuer_validation,
        token_reviewer_jwt: :token_reviewer_jwt
      },
      map: [:name]
  end
  module Akeyless
    include DataAkeylessK8sAuthConfig
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
