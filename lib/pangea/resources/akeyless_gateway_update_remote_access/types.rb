# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayUpdateRemoteAccessAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute? :enable, T::String.optional
    attribute? :bastion_allowed_access_ids, T::String.optional
    attribute :hide_session_recording, T::Bool.default(false)
  end
end
