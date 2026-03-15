# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_azure_target/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessAzureTarget
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_azure_target,
      attributes_class: Akeyless::Types::AzureTargetAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:client_id, :tenant_id, :client_secret, :key, :description, :resource_group_name, :resource_name_, :subscription_id],
      map_bool: [:use_gw_cloud_identity]
  end
  module Akeyless
    include AkeylessAzureTarget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
