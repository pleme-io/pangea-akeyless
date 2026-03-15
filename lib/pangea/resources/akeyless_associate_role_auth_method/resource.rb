# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_associate_role_auth_method/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessAssociateRoleAuthMethod
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_associate_role_auth_method,
      attributes_class: Akeyless::Types::AssociateRoleAuthMethodAttributes,
      outputs: { id: :id },
      map: [:role_name, :am_name],
      map_present: [:case_sensitive] do |r, attrs|
        if attrs.sub_claims.any?
          r.sub_claims do
            attrs.sub_claims.each { |k, v| public_send(k, v) }
          end
        end
      end
  end
  module Akeyless
    include AkeylessAssociateRoleAuthMethod
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
