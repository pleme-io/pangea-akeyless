# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_producer_custom/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayProducerCustom
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_producer_custom,
      attributes_class: Akeyless::Types::GatewayProducerCustomAttributes,
      outputs: { id: :id },
      map: [:name, :create_sync_url, :revoke_sync_url],
      map_present: [:target_name, :user_ttl, :producer_encryption_key_name, :payload, :timeout_sec],
      map_bool: [:enable_admin_rotation] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessGatewayProducerCustom
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
