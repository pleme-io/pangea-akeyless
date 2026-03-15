# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_rabbitmq_target/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessRabbitmqTarget
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_rabbitmq_target,
      attributes_class: Akeyless::Types::RabbitmqTargetAttributes,
      outputs: { id: :id, name: :name },
      map: [:name, :rabbitmq_server_uri],
      map_present: [:rabbitmq_server_user, :rabbitmq_server_password, :key, :description]
  end
  module Akeyless
    include AkeylessRabbitmqTarget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
