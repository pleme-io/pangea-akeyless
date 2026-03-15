# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_classic_key/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessClassicKey
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_classic_key,
      attributes_class: Akeyless::Types::ClassicKeyAttributes,
      outputs: { id: :id, name: :name },
      map: [:name, :alg],
      map_present: [:description, :key_data, :cert_file_data, :gpg_alg,
                    :protection_key_name, :certificate_ttl, :certificate_common_name,
                    :certificate_organization, :certificate_country, :certificate_locality,
                    :certificate_province, :conf_file_data, :certificate_format,
                    :auto_rotate, :rotation_interval, :delete_protection],
      map_bool: [:generate_self_signed_certificate] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
        r.expiration_event_in attrs.expiration_event_in if attrs.expiration_event_in.any?
        r.rotation_event_in attrs.rotation_event_in if attrs.rotation_event_in.any?
      end
  end
  module Akeyless
    include AkeylessClassicKey
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
