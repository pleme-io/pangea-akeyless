# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_k8s_target/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessK8sTarget
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_k8s_target,
      attributes_class: Akeyless::Types::K8sTargetAttributes,
      outputs: { id: :id, name: :name },
      map: [:name, :k8s_cluster_endpoint, :k8s_cluster_ca_cert, :k8s_cluster_token],
      map_present: [:key, :description]
  end
  module Akeyless
    include AkeylessK8sTarget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
