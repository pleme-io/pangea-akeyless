# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_target/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessTarget
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_target,
      attributes_class: Akeyless::Types::TargetDataAttributes,
      outputs: { target_type: :target_type, target_details: :target_details },
      map: [:name]
  end
  module Akeyless
    include DataAkeylessTarget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
