# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_auth_method_oauth2/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessAuthMethodOauth2
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_auth_method_oauth2,
      attributes_class: Akeyless::Types::AuthMethodOauth2Attributes,
      outputs: { id: :id, access_id: :access_id },
      map: [:name, :unique_identifier],
      map_present: [:access_expires, :jwt_ttl, :jwks_uri, :jwks_json_data, :issuer, :audience, :delete_protection, :gateway_url],
      map_bool: [:force_sub_claims] do |r, attrs|
        r.bound_ips attrs.bound_ips if attrs.bound_ips.any?
        r.bound_client_ids attrs.bound_client_ids if attrs.bound_client_ids.any?
        r.audit_logs_claims attrs.audit_logs_claims if attrs.audit_logs_claims.any?
      end
  end
  module Akeyless
    include AkeylessAuthMethodOauth2
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
