# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_dynamic_secret_eks/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessDynamicSecretEks
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_dynamic_secret_eks,
      attributes_class: Akeyless::Types::DynamicSecretEksAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:target_name, :eks_cluster_name, :eks_cluster_endpoint, :eks_cluster_ca_cert,
                    :eks_access_key_id, :eks_secret_access_key, :eks_region, :user_ttl,
                    :encryption_key_name] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessDynamicSecretEks
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
