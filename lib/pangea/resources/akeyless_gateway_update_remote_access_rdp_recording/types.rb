# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayUpdateRemoteAccessRdpRecordingAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute? :rdp_session_recording, T::String.optional
    attribute? :rdp_active_directory, T::String.optional
  end
end
