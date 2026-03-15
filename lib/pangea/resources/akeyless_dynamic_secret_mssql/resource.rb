# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_dynamic_secret_mssql/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessDynamicSecretMssql
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_dynamic_secret_mssql,
      attributes_class: Akeyless::Types::DynamicSecretMssqlAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:target_name, :mssql_dbname, :mssql_username, :mssql_password, :mssql_host,
                    :mssql_port, :mssql_creation_statements, :mssql_revocation_statements,
                    :user_ttl, :encryption_key_name] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessDynamicSecretMssql
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
