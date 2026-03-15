# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_dynamic_secret_rdp/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessDynamicSecretRdp
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_dynamic_secret_rdp,
      attributes_class: Akeyless::Types::DynamicSecretRdpAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:target_name, :rdp_admin_name, :rdp_admin_pwd, :rdp_host_name, :rdp_host_port,
                    :rdp_user_groups, :user_ttl, :encryption_key_name] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessDynamicSecretRdp
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
