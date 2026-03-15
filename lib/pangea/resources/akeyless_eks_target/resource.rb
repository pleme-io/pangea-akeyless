# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_eks_target/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessEksTarget
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_eks_target,
      attributes_class: Akeyless::Types::EksTargetAttributes,
      outputs: { id: :id, name: :name },
      map: [:name, :eks_cluster_name, :eks_cluster_endpoint, :eks_cluster_ca_cert, :eks_access_key_id],
      map_present: [:eks_secret_access_key, :eks_region, :key, :description],
      map_bool: [:use_gw_cloud_identity]
  end
  module Akeyless
    include AkeylessEksTarget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
