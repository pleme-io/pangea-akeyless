# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class PkiCertificateDataAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :cert_issuer_name, T::String
    attribute? :key_data_base64, T::String.optional
    attribute? :csr_data_base64, T::String.optional
    attribute? :common_name, T::String.optional
    attribute? :alt_names, T::String.optional
    attribute? :uri_sans, T::String.optional
    attribute? :ttl, T::Integer.optional
  end
end
