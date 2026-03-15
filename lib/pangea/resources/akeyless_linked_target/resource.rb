# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_linked_target/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessLinkedTarget
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_linked_target,
      attributes_class: Akeyless::Types::LinkedTargetAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:parent_target_name, :hosts, :description]
  end
  module Akeyless
    include AkeylessLinkedTarget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
