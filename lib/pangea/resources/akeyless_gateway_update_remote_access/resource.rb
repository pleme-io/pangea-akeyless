# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_update_remote_access/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayUpdateRemoteAccess

    def akeyless_gateway_update_remote_access(name, attributes = {})
      attrs = Akeyless::Types::GatewayUpdateRemoteAccessAttributes.new(attributes)
      resource(:akeyless_gateway_update_remote_access, name) do
        enable attrs.enable if attrs.enable
        bastion_allowed_access_ids attrs.bastion_allowed_access_ids if attrs.bastion_allowed_access_ids
        hide_session_recording attrs.hide_session_recording unless attrs.hide_session_recording.nil?
      end
      ResourceReference.new(type: 'akeyless_gateway_update_remote_access', name: name, resource_attributes: attrs.to_h,
                            outputs: { id: "${akeyless_gateway_update_remote_access.#{name}.id}" })
    end
  end
  module Akeyless
    include AkeylessGatewayUpdateRemoteAccess
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
