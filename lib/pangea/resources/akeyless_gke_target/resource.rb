# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gke_target/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGkeTarget
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gke_target,
      attributes_class: Akeyless::Types::GkeTargetAttributes,
      outputs: { id: :id, name: :name },
      map: [:name, :gke_cluster_endpoint, :gke_cluster_ca_cert, :gke_cluster_name],
      map_present: [:gke_account_key, :gke_service_account_email, :key, :description],
      map_bool: [:use_gw_cloud_identity]
  end
  module Akeyless
    include AkeylessGkeTarget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
