# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_dynamic_secret_postgresql/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessDynamicSecretPostgresql
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_dynamic_secret_postgresql,
      attributes_class: Akeyless::Types::DynamicSecretPostgresqlAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:target_name, :postgresql_db_name, :postgresql_username, :postgresql_password,
                    :postgresql_host, :postgresql_port, :creation_statements, :revocation_statements,
                    :user_ttl, :encryption_key_name, :ssl_certificate],
      map_bool: [:ssl] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessDynamicSecretPostgresql
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
