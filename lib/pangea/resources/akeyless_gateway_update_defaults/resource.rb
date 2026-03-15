# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_update_defaults/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayUpdateDefaults

    def akeyless_gateway_update_defaults(name, attributes = {})
      attrs = Akeyless::Types::GatewayUpdateDefaultsAttributes.new(attributes)
      resource(:akeyless_gateway_update_defaults, name) do
        saml_access_id attrs.saml_access_id if attrs.saml_access_id
        oidc_access_id attrs.oidc_access_id if attrs.oidc_access_id
        cert_access_id attrs.cert_access_id if attrs.cert_access_id
        default_key attrs.default_key if attrs.default_key
      end
      ResourceReference.new(type: 'akeyless_gateway_update_defaults', name: name, resource_attributes: attrs.to_h,
                            outputs: { id: "${akeyless_gateway_update_defaults.#{name}.id}" })
    end
  end
  module Akeyless
    include AkeylessGatewayUpdateDefaults
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
