# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_auth_method_gcp/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessAuthMethodGcp
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_auth_method_gcp,
      attributes_class: Akeyless::Types::AuthMethodGcpAttributes,
      outputs: { id: :id, access_id: :access_id },
      map: [:name, :type, :audience],
      map_present: [:access_expires, :jwt_ttl, :service_account_creds_data, :delete_protection],
      map_bool: [:force_sub_claims] do |r, attrs|
        r.bound_ips attrs.bound_ips if attrs.bound_ips.any?
        r.bound_projects attrs.bound_projects if attrs.bound_projects.any?
        r.bound_service_accounts attrs.bound_service_accounts if attrs.bound_service_accounts.any?
        r.bound_zones attrs.bound_zones if attrs.bound_zones.any?
        r.bound_regions attrs.bound_regions if attrs.bound_regions.any?
        r.bound_labels attrs.bound_labels if attrs.bound_labels.any?
        r.audit_logs_claims attrs.audit_logs_claims if attrs.audit_logs_claims.any?
      end
  end
  module Akeyless
    include AkeylessAuthMethodGcp
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
