# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_rotated_secret_value/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessRotatedSecretValue
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_rotated_secret_value,
      attributes_class: Akeyless::Types::RotatedSecretValueDataAttributes,
      outputs: { value: :value },
      map: [:name],
      map_present: [:version]
  end
  module Akeyless
    include DataAkeylessRotatedSecretValue
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
