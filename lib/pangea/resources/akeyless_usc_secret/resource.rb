# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_usc_secret/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessUscSecret
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_usc_secret,
      attributes_class: Akeyless::Types::UscSecretAttributes,
      outputs: { id: :id },
      map: [:name, :usc_name],
      map_present: [:description]
  end
  module Akeyless
    include AkeylessUscSecret
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
