# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_secret/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessSecret
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_secret,
      attributes_class: Akeyless::Types::SecretDataAttributes,
      outputs: { value: :value },
      map: [:path],
      map_present: [:version]
  end
  module Akeyless
    include DataAkeylessSecret
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
