# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayUpdateDefaultsAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute? :saml_access_id, T::String.optional
    attribute? :oidc_access_id, T::String.optional
    attribute? :cert_access_id, T::String.optional
    attribute? :default_key, T::String.optional
  end
end
