# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_dynamic_secret/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessDynamicSecret
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_dynamic_secret,
      attributes_class: Akeyless::Types::DynamicSecretDataAttributes,
      outputs: { value: :value },
      map: [:path]
  end
  module Akeyless
    include DataAkeylessDynamicSecret
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
