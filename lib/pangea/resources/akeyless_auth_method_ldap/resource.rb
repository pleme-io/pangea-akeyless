# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_auth_method_ldap/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessAuthMethodLdap
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_auth_method_ldap,
      attributes_class: Akeyless::Types::AuthMethodLdapAttributes,
      outputs: { id: :id, access_id: :access_id },
      map: [:name],
      map_present: [:access_expires, :jwt_ttl, :public_key_data, :unique_identifier, :delete_protection],
      map_bool: [:force_sub_claims] do |r, attrs|
        r.bound_ips attrs.bound_ips if attrs.bound_ips.any?
        r.audit_logs_claims attrs.audit_logs_claims if attrs.audit_logs_claims.any?
      end
  end
  module Akeyless
    include AkeylessAuthMethodLdap
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
