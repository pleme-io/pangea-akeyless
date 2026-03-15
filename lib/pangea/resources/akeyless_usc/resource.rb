# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_usc/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessUsc
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_usc,
      attributes_class: Akeyless::Types::UscAttributes,
      outputs: { id: :id },
      map: [:name],
      map_present: [:description]
  end
  module Akeyless
    include AkeylessUsc
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
