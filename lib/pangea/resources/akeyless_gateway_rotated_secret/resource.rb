# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_rotated_secret/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayRotatedSecret
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_rotated_secret,
      attributes_class: Akeyless::Types::GatewayRotatedSecretAttributes,
      outputs: { id: :id },
      map: [:name, :target_name, :rotator_type],
      map_present: [:auto_rotate, :rotation_interval, :rotation_hour, :rotated_username,
                    :rotated_password, :key]
  end
  module Akeyless
    include AkeylessGatewayRotatedSecret
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
