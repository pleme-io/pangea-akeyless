# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_producer_rdp/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayProducerRdp
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_producer_rdp,
      attributes_class: Akeyless::Types::GatewayProducerRdpAttributes,
      outputs: { id: :id },
      map: [:name],
      map_present: [:target_name, :user_ttl, :producer_encryption_key_name,
                    :rdp_admin_name, :rdp_admin_pwd, :rdp_host_name, :rdp_host_port,
                    :rdp_user_groups] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessGatewayProducerRdp
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
