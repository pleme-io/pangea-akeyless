# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_dynamic_secret_cassandra/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessDynamicSecretCassandra
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_dynamic_secret_cassandra,
      attributes_class: Akeyless::Types::DynamicSecretCassandraAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:target_name, :cassandra_hosts, :cassandra_port, :cassandra_username,
                    :cassandra_password, :cassandra_creation_statements, :user_ttl,
                    :encryption_key_name] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessDynamicSecretCassandra
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
