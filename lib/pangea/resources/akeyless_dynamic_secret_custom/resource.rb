# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_dynamic_secret_custom/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessDynamicSecretCustom
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_dynamic_secret_custom,
      attributes_class: Akeyless::Types::DynamicSecretCustomAttributes,
      outputs: { id: :id, name: :name },
      map: [:name, :create_sync_url, :revoke_sync_url],
      map_present: [:payload, :user_ttl, :encryption_key_name, :admin_rotation_interval_days,
                    :timeout_sec],
      map_bool: [:enable_admin_rotation] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessDynamicSecretCustom
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
