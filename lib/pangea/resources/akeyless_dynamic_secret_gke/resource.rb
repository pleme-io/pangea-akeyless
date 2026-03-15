# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_dynamic_secret_gke/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessDynamicSecretGke
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_dynamic_secret_gke,
      attributes_class: Akeyless::Types::DynamicSecretGkeAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:target_name, :gke_cluster_endpoint, :gke_cluster_ca_cert, :gke_account_key,
                    :gke_cluster_name, :gke_service_account_email, :user_ttl,
                    :encryption_key_name] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessDynamicSecretGke
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
