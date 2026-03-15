# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_target_details/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessTargetDetails
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_target_details,
      attributes_class: Akeyless::Types::TargetDetailsDataAttributes,
      outputs: { value: :value },
      map: [:name]
  end
  module Akeyless
    include DataAkeylessTargetDetails
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
