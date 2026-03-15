# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_ssh_target/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessSshTarget
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_ssh_target,
      attributes_class: Akeyless::Types::SshTargetAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:host, :port, :ssh_username, :ssh_password, :private_key, :private_key_password, :key, :description]
  end
  module Akeyless
    include AkeylessSshTarget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
