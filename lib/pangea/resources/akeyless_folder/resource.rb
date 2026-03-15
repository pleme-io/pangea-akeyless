# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_folder/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessFolder
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_folder,
      attributes_class: Akeyless::Types::FolderAttributes,
      outputs: { id: :id, folder_id: :folder_id },
      map: [:name],
      map_present: [:description, :delete_protection] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessFolder
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
