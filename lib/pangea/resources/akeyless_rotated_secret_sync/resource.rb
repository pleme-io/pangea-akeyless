# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_rotated_secret_sync/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessRotatedSecretSync
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_rotated_secret_sync,
      attributes_class: Akeyless::Types::RotatedSecretSyncAttributes,
      outputs: { id: :id },
      map: [:name, :target_name],
      map_present: [:description],
      map_bool: [] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessRotatedSecretSync
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
