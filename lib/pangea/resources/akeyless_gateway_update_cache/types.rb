# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayUpdateCacheAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :enabled, T::Bool.default(true)
    attribute :stale_timeout, T::String.default('60m')
    attribute :cache_ttl, T::Integer.default(60)
    attribute? :proactive_caching_frequency, T::String.optional
  end
end
