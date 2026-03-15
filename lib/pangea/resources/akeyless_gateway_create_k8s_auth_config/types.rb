# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayCreateK8sAuthConfigAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :access_id, T::String
    attribute :signing_key, T::String
    attribute? :config_encryption_key_name, T::String.optional
    attribute? :k8s_host, T::String.optional
    attribute? :k8s_ca_cert, T::String.optional
    attribute? :token_reviewer_jwt, T::String.optional
    attribute? :k8s_issuer, T::String.optional
    attribute :disable_issuer_validation, T::Bool.default(false)
  end
end
