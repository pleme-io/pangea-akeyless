# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_auth_method/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessAuthMethod
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_auth_method,
      attributes_class: Akeyless::Types::AuthMethodAttributes,
      outputs: { id: :id, access_id: :access_id },
      map: [:name],
      map_present: [:access_expires, :jwt_ttl, :delete_protection],
      map_bool: [:force_sub_claims] do |r, attrs|
        r.bound_ips attrs.bound_ips if attrs.bound_ips.any?
      end
  end
  module Akeyless
    include AkeylessAuthMethod
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
