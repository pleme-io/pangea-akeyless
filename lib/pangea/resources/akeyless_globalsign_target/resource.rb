# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_globalsign_target/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGlobalsignTarget
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_globalsign_target,
      attributes_class: Akeyless::Types::GlobalsignTargetAttributes,
      outputs: { id: :id, name: :name },
      map: [:name, :username, :contact_first_name, :contact_last_name, :contact_email, :contact_phone, :profile_id],
      map_present: [:password, :key, :description]
  end
  module Akeyless
    include AkeylessGlobalsignTarget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
