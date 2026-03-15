# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_auth_method_saml/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessAuthMethodSaml
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_auth_method_saml,
      attributes_class: Akeyless::Types::AuthMethodSamlAttributes,
      outputs: { id: :id, access_id: :access_id },
      map: [:name, :unique_identifier],
      map_present: [:access_expires, :jwt_ttl, :idp_metadata_url, :idp_metadata_xml_data, :delete_protection],
      map_bool: [:force_sub_claims] do |r, attrs|
        r.bound_ips attrs.bound_ips if attrs.bound_ips.any?
        r.allowed_redirect_uri attrs.allowed_redirect_uri if attrs.allowed_redirect_uri.any?
        r.audit_logs_claims attrs.audit_logs_claims if attrs.audit_logs_claims.any?
      end
  end
  module Akeyless
    include AkeylessAuthMethodSaml
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
