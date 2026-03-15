# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gcp_target/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGcpTarget
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gcp_target,
      attributes_class: Akeyless::Types::GcpTargetAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:gcp_sa_email, :gcp_key_data, :key, :description],
      map_bool: [:use_gw_cloud_identity]
  end
  module Akeyless
    include AkeylessGcpTarget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
