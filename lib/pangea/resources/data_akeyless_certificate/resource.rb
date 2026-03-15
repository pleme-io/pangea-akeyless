# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_certificate/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessCertificate
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_certificate,
      attributes_class: Akeyless::Types::CertificateDataAttributes,
      outputs: { certificate_pem: :certificate_pem, private_key_pem: :private_key_pem },
      map: [:name]
  end
  module Akeyless
    include DataAkeylessCertificate
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
