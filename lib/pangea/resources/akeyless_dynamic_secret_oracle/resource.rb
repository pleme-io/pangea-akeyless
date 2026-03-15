# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_dynamic_secret_oracle/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessDynamicSecretOracle
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_dynamic_secret_oracle,
      attributes_class: Akeyless::Types::DynamicSecretOracleAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:target_name, :oracle_host, :oracle_port, :oracle_service_name,
                    :oracle_username, :oracle_password, :oracle_creation_statements,
                    :oracle_revocation_statements, :user_ttl,
                    :encryption_key_name] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessDynamicSecretOracle
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
