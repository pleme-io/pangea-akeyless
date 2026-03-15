# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_auth_method_oidc/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessAuthMethodOidc
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_auth_method_oidc,
      attributes_class: Akeyless::Types::AuthMethodOidcAttributes,
      outputs: { id: :id, access_id: :access_id },
      map: [:name, :unique_identifier],
      map_present: [:access_expires, :jwt_ttl, :issuer, :client_id, :client_secret, :required_scopes_prefix, :delete_protection],
      map_bool: [:force_sub_claims] do |r, attrs|
        r.bound_ips attrs.bound_ips if attrs.bound_ips.any?
        r.allowed_redirect_uri attrs.allowed_redirect_uri if attrs.allowed_redirect_uri.any?
        r.required_scopes attrs.required_scopes if attrs.required_scopes.any?
        r.audit_logs_claims attrs.audit_logs_claims if attrs.audit_logs_claims.any?
      end
  end
  module Akeyless
    include AkeylessAuthMethodOidc
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
