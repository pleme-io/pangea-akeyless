# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class PkiCertIssuerAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :ttl, T::String
    attribute? :signer_key_name, T::String.optional
    attribute? :allowed_domains, T::String.optional
    attribute? :allowed_uri_sans, T::String.optional
    attribute? :allowed_ip_sans, T::String.optional
    attribute? :allow_subdomains, T::Bool.optional
    attribute? :not_enforce_hostnames, T::Bool.optional
    attribute? :allow_any_name, T::Bool.optional
    attribute? :not_require_cn, T::Bool.optional
    attribute? :server_flag, T::Bool.optional
    attribute? :client_flag, T::Bool.optional
    attribute? :code_signing_flag, T::Bool.optional
    attribute :key_usage, T::String.optional.default("DigitalSignature,KeyAgreement,KeyEncipherment")
    attribute :critical_key_usage, T::String.optional.default("true")
    attribute? :organizational_units, T::String.optional
    attribute? :organizations, T::String.optional
    attribute? :country, T::String.optional
    attribute? :locality, T::String.optional
    attribute? :province, T::String.optional
    attribute? :street_address, T::String.optional
    attribute? :postal_code, T::String.optional
    attribute? :description, T::String.optional
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute? :ca_target, T::String.optional
    attribute? :gw_cluster_url, T::String.optional
    attribute? :destination_path, T::String.optional
    attribute? :protect_certificates, T::Bool.optional
    attribute? :is_ca, T::Bool.optional
    attribute? :enable_acme, T::Bool.optional
    attribute? :allow_copy_ext_from_csr, T::Bool.optional
    attribute? :create_public_crl, T::Bool.optional
    attribute? :create_private_crl, T::Bool.optional
    attribute? :auto_renew, T::Bool.optional
    attribute :expiration_event_in, T::Array.of(T::String).default([].freeze)
    attribute? :allowed_extra_extensions, T::String.optional
    attribute? :scheduled_renew, T::Integer.optional
    attribute? :delete_protection, T::Bool.optional
  end
end
