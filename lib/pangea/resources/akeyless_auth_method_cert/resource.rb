# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_auth_method_cert/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessAuthMethodCert
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_auth_method_cert,
      attributes_class: Akeyless::Types::AuthMethodCertAttributes,
      outputs: { id: :id, access_id: :access_id },
      map: [:name, :unique_identifier],
      map_present: [:access_expires, :jwt_ttl, :certificate_data, :delete_protection],
      map_bool: [:force_sub_claims] do |r, attrs|
        r.bound_ips attrs.bound_ips if attrs.bound_ips.any?
        r.bound_common_names attrs.bound_common_names if attrs.bound_common_names.any?
        r.bound_dns_sans attrs.bound_dns_sans if attrs.bound_dns_sans.any?
        r.bound_email_sans attrs.bound_email_sans if attrs.bound_email_sans.any?
        r.bound_uri_sans attrs.bound_uri_sans if attrs.bound_uri_sans.any?
        r.bound_organizational_units attrs.bound_organizational_units if attrs.bound_organizational_units.any?
        r.bound_extensions attrs.bound_extensions if attrs.bound_extensions.any?
        r.revoked_cert_ids attrs.revoked_cert_ids if attrs.revoked_cert_ids.any?
        r.audit_logs_claims attrs.audit_logs_claims if attrs.audit_logs_claims.any?
      end
  end
  module Akeyless
    include AkeylessAuthMethodCert
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
