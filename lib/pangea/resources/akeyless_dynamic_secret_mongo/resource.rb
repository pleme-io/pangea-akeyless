# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_dynamic_secret_mongo/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessDynamicSecretMongo
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_dynamic_secret_mongo,
      attributes_class: Akeyless::Types::DynamicSecretMongoAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:target_name, :mongodb_host_port, :mongodb_name, :mongodb_server_uri,
                    :mongodb_username, :mongodb_password, :mongodb_default_auth_db,
                    :mongodb_uri_options, :mongodb_roles, :user_ttl,
                    :encryption_key_name] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessDynamicSecretMongo
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
