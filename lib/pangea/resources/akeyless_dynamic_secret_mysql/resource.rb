# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_dynamic_secret_mysql/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessDynamicSecretMysql
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_dynamic_secret_mysql,
      attributes_class: Akeyless::Types::DynamicSecretMysqlAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:target_name, :mysql_dbname, :mysql_username, :mysql_password, :mysql_host,
                    :mysql_port, :mysql_creation_statements, :mysql_revocation_statements,
                    :user_ttl, :encryption_key_name, :ssl_certificate],
      map_bool: [:ssl] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessDynamicSecretMysql
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
