# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_auth_method_azure_ad/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessAuthMethodAzureAd
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_auth_method_azure_ad,
      attributes_class: Akeyless::Types::AuthMethodAzureAdAttributes,
      outputs: { id: :id, access_id: :access_id },
      map: [:name, :bound_tenant_id],
      map_present: [:access_expires, :jwt_ttl, :issuer, :jwks_uri, :audience, :delete_protection],
      map_bool: [:force_sub_claims] do |r, attrs|
        r.bound_ips attrs.bound_ips if attrs.bound_ips.any?
        r.bound_spid attrs.bound_spid if attrs.bound_spid.any?
        r.bound_group_id attrs.bound_group_id if attrs.bound_group_id.any?
        r.bound_sub_id attrs.bound_sub_id if attrs.bound_sub_id.any?
        r.bound_rg_id attrs.bound_rg_id if attrs.bound_rg_id.any?
        r.bound_providers attrs.bound_providers if attrs.bound_providers.any?
        r.bound_resource_types attrs.bound_resource_types if attrs.bound_resource_types.any?
        r.bound_resource_names attrs.bound_resource_names if attrs.bound_resource_names.any?
        r.bound_resource_id attrs.bound_resource_id if attrs.bound_resource_id.any?
        r.audit_logs_claims attrs.audit_logs_claims if attrs.audit_logs_claims.any?
      end
  end
  module Akeyless
    include AkeylessAuthMethodAzureAd
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
