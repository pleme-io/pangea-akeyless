# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_items/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessItems
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_items,
      attributes_class: Akeyless::Types::ItemsDataAttributes,
      outputs: { items: :items },
      map_present: [:path, :type, :filter, :pagination_token, :tag]
  end
  module Akeyless
    include DataAkeylessItems
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
