# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_allowed_access/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayAllowedAccess
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_allowed_access,
      attributes_class: Akeyless::Types::GatewayAllowedAccessAttributes,
      outputs: { id: :id, name: :name },
      map: [:name, :access_id],
      map_present: [:description, :permissions] do |r, attrs|
        if attrs.sub_claims.any?
          r.sub_claims do
            attrs.sub_claims.each { |k, v| public_send(k, v) }
          end
        end
      end
  end
  module Akeyless
    include AkeylessGatewayAllowedAccess
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
