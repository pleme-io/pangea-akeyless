# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_static_secret/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessStaticSecret
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_static_secret,
      attributes_class: Akeyless::Types::StaticSecretDataAttributes,
      outputs: { value: :value },
      map: [:path],
      map_present: [:version]
  end
  module Akeyless
    include DataAkeylessStaticSecret
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
