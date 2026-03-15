# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_dynamic_secret_azure/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessDynamicSecretAzure
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_dynamic_secret_azure,
      attributes_class: Akeyless::Types::DynamicSecretAzureAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:azure_tenant_id, :azure_client_id, :azure_client_secret, :user_ttl,
                    :encryption_key_name] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessDynamicSecretAzure
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
