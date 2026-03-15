# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class SshCertificateDataAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :cert_issuer_name, T::String
    attribute :cert_username, T::String
    attribute :public_key_data, T::String
    attribute? :ttl, T::Integer.optional
  end
end
