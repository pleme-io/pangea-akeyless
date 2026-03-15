# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_pki_certificate/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessPkiCertificate
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_pki_certificate,
      attributes_class: Akeyless::Types::PkiCertificateDataAttributes,
      outputs: { data: :data, parent_cert: :parent_cert, reading_token: :reading_token },
      map: [:cert_issuer_name],
      map_present: [:key_data_base64, :csr_data_base64, :common_name,
                    :alt_names, :uri_sans, :ttl]
  end
  module Akeyless
    include DataAkeylessPkiCertificate
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
