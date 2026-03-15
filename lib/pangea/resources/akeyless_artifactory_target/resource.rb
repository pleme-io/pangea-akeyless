# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_artifactory_target/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessArtifactoryTarget
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_artifactory_target,
      attributes_class: Akeyless::Types::ArtifactoryTargetAttributes,
      outputs: { id: :id, name: :name },
      map: [:name, :base_url, :artifactory_admin_name],
      map_present: [:artifactory_admin_pwd, :key, :description]
  end
  module Akeyless
    include AkeylessArtifactoryTarget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
