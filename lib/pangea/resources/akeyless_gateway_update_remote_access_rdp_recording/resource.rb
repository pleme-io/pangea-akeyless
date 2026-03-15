# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_update_remote_access_rdp_recording/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayUpdateRemoteAccessRdpRecording

    def akeyless_gateway_update_remote_access_rdp_recording(name, attributes = {})
      attrs = Akeyless::Types::GatewayUpdateRemoteAccessRdpRecordingAttributes.new(attributes)
      resource(:akeyless_gateway_update_remote_access_rdp_recording, name) do
        rdp_session_recording attrs.rdp_session_recording if attrs.rdp_session_recording
        rdp_active_directory attrs.rdp_active_directory if attrs.rdp_active_directory
      end
      ResourceReference.new(type: 'akeyless_gateway_update_remote_access_rdp_recording', name: name,
                            resource_attributes: attrs.to_h,
                            outputs: { id: "${akeyless_gateway_update_remote_access_rdp_recording.#{name}.id}" })
    end
  end
  module Akeyless
    include AkeylessGatewayUpdateRemoteAccessRdpRecording
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
