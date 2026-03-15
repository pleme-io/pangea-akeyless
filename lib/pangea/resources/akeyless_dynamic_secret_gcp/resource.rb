# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_dynamic_secret_gcp/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessDynamicSecretGcp
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_dynamic_secret_gcp,
      attributes_class: Akeyless::Types::DynamicSecretGcpAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:target_name, :gcp_sa_email, :gcp_key_data, :role_binding,
                    :service_account_type, :user_ttl, :encryption_key_name] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessDynamicSecretGcp
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
