# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_windows_target/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessWindowsTarget
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_windows_target,
      attributes_class: Akeyless::Types::WindowsTargetAttributes,
      outputs: { id: :id, name: :name },
      map: [:name, :hostname, :username],
      map_present: [:password, :domain, :key, :description, :use_tls, :port]
  end
  module Akeyless
    include AkeylessWindowsTarget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
