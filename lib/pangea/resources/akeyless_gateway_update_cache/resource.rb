# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_update_cache/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayUpdateCache

    def akeyless_gateway_update_cache(name, attributes = {})
      attrs = Akeyless::Types::GatewayUpdateCacheAttributes.new(attributes)
      resource(:akeyless_gateway_update_cache, name) do
        enabled attrs.enabled unless attrs.enabled.nil?
        stale_timeout attrs.stale_timeout if attrs.stale_timeout
        cache_ttl attrs.cache_ttl if attrs.cache_ttl
        proactive_caching_frequency attrs.proactive_caching_frequency if attrs.proactive_caching_frequency
      end
      ResourceReference.new(type: 'akeyless_gateway_update_cache', name: name, resource_attributes: attrs.to_h,
                            outputs: { id: "${akeyless_gateway_update_cache.#{name}.id}" })
    end
  end
  module Akeyless
    include AkeylessGatewayUpdateCache
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
