# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_rotated_secret_gcp/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessRotatedSecretGcp
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_rotated_secret_gcp,
      attributes_class: Akeyless::Types::RotatedSecretGcpAttributes,
      outputs: { id: :id, name: :name },
      map: [:name, :target_name, :rotator_type],
      map_present: [:description, :rotation_interval, :rotation_hour, :auto_rotate, :key,
                    :rotated_username, :rotated_password, :delete_protection,
                    :gcp_key_type],
      map_bool: [] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
        r.rotation_event_in attrs.rotation_event_in if attrs.rotation_event_in.any?
      end
  end
  module Akeyless
    include AkeylessRotatedSecretGcp
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
