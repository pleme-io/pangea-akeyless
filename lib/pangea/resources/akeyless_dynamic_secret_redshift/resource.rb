# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_dynamic_secret_redshift/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessDynamicSecretRedshift
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_dynamic_secret_redshift,
      attributes_class: Akeyless::Types::DynamicSecretRedshiftAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:target_name, :redshift_db_name, :redshift_username, :redshift_password,
                    :redshift_host, :redshift_port, :creation_statements, :user_ttl,
                    :encryption_key_name, :ssl_certificate],
      map_bool: [:ssl] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessDynamicSecretRedshift
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
