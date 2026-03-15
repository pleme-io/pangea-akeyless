# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_db_target/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessDbTarget
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_db_target,
      attributes_class: Akeyless::Types::DbTargetAttributes,
      outputs: { id: :id, name: :name },
      map: [:name, :db_type],
      map_present: [:user_name, :host, :pwd, :port, :db_name, :db_server_certificates, :db_server_name, :ssl_certificate, :snowflake_account, :mongodb_default_auth_db, :mongodb_uri_options, :mongodb_atlas_project_id, :mongodb_atlas_api_public_key, :mongodb_atlas_api_private_key, :key, :description, :oracle_service_name],
      map_bool: [:ssl, :mongodb_atlas]
  end
  module Akeyless
    include AkeylessDbTarget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
