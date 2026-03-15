# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_auth_method_api_key/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessAuthMethodApiKey
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_auth_method_api_key,
      attributes_class: Akeyless::Types::AuthMethodApiKeyAttributes,
      outputs: { id: :id, access_id: :access_id, access_key: :access_key },
      map: [:name],
      map_present: [:access_expires, :jwt_ttl, :delete_protection],
      map_bool: [:force_sub_claims] do |r, attrs|
        r.bound_ips attrs.bound_ips if attrs.bound_ips.any?
        r.audit_logs_claims attrs.audit_logs_claims if attrs.audit_logs_claims.any?
      end
  end
  module Akeyless
    include AkeylessAuthMethodApiKey
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
