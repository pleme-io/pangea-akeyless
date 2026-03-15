# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class ClassicKeyAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :alg, T::String.constrained(
      included_in: %w[
        AES128GCM AES256GCM AES128SIV AES256SIV AES128CBC AES256CBC
        RSA1024 RSA2048 RSA3072 RSA4096 EC256 EC384 GPG
      ]
    )
    attribute? :description, T::String.optional
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute? :key_data, T::String.optional
    attribute? :cert_file_data, T::String.optional
    attribute? :gpg_alg, T::String.optional
    attribute? :protection_key_name, T::String.optional
    attribute :generate_self_signed_certificate, T::Bool.default(false)
    attribute? :certificate_ttl, T::Integer.optional
    attribute? :certificate_common_name, T::String.optional
    attribute? :certificate_organization, T::String.optional
    attribute? :certificate_country, T::String.optional
    attribute? :certificate_locality, T::String.optional
    attribute? :certificate_province, T::String.optional
    attribute? :conf_file_data, T::String.optional
    attribute :certificate_format, T::String.default("pem")
    attribute :expiration_event_in, T::Array.of(T::String).default([].freeze)
    attribute :auto_rotate, T::String.default("false")
    attribute :rotation_interval, T::String.default("90")
    attribute :rotation_event_in, T::Array.of(T::String).default([].freeze)
    attribute? :delete_protection, T::String.optional
  end
end
