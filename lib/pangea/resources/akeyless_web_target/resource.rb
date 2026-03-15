# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_web_target/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessWebTarget
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_web_target,
      attributes_class: Akeyless::Types::WebTargetAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:url, :key, :description]
  end
  module Akeyless
    include AkeylessWebTarget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
