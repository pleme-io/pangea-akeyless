# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_certificate/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessCertificate
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_certificate,
      attributes_class: Akeyless::Types::CertificateAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:certificate_data, :format, :key_data, :key, :description,
                    :delete_protection] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
        r.expiration_event_in attrs.expiration_event_in if attrs.expiration_event_in.any?
      end
  end
  module Akeyless
    include AkeylessCertificate
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
