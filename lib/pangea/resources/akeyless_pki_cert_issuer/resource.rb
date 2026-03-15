# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_pki_cert_issuer/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessPkiCertIssuer
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_pki_cert_issuer,
      attributes_class: Akeyless::Types::PkiCertIssuerAttributes,
      outputs: { id: :id, name: :name },
      map: [:name, :ttl],
      map_present: [:signer_key_name, :allowed_domains, :allowed_uri_sans, :allowed_ip_sans,
                    :key_usage, :critical_key_usage, :organizational_units, :organizations,
                    :country, :locality, :province, :street_address, :postal_code,
                    :description, :ca_target, :gw_cluster_url, :destination_path,
                    :allowed_extra_extensions, :scheduled_renew],
      map_bool: [:allow_subdomains, :not_enforce_hostnames, :allow_any_name, :not_require_cn,
                 :server_flag, :client_flag, :code_signing_flag, :protect_certificates,
                 :is_ca, :enable_acme, :allow_copy_ext_from_csr, :create_public_crl,
                 :create_private_crl, :auto_renew, :delete_protection] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
        r.expiration_event_in attrs.expiration_event_in if attrs.expiration_event_in.any?
      end
  end
  module Akeyless
    include AkeylessPkiCertIssuer
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
