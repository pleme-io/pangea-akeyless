# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_static_secret_sync/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessStaticSecretSync
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_static_secret_sync,
      attributes_class: Akeyless::Types::StaticSecretSyncAttributes,
      outputs: { id: :id },
      map: [:name],
      map_present: [:description]
  end
  module Akeyless
    include AkeylessStaticSecretSync
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
