# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_tags/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessTags
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_tags,
      attributes_class: Akeyless::Types::TagsDataAttributes,
      outputs: { tags: :tags },
      map: [:name]
  end
  module Akeyless
    include DataAkeylessTags
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
