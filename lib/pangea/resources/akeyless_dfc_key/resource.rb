# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_dfc_key/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessDfcKey
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_dfc_key,
      attributes_class: Akeyless::Types::DfcKeyAttributes,
      outputs: { id: :id, name: :name },
      map: [:name, :alg],
      map_present: [:description, :split_level, :customer_frg_id,
                    :certificate_ttl, :certificate_common_name,
                    :certificate_organization, :certificate_country, :certificate_locality,
                    :certificate_province, :cert_data_base64, :conf_file_data,
                    :certificate_format, :auto_rotate, :rotation_interval],
      map_bool: [:generate_self_signed_certificate, :delete_protection] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
        r.expiration_event_in attrs.expiration_event_in if attrs.expiration_event_in.any?
        r.rotation_event_in attrs.rotation_event_in if attrs.rotation_event_in.any?
      end
  end
  module Akeyless
    include AkeylessDfcKey
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
