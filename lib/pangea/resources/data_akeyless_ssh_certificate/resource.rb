# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_ssh_certificate/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessSshCertificate
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_ssh_certificate,
      attributes_class: Akeyless::Types::SshCertificateDataAttributes,
      outputs: { data: :data },
      map: [:cert_issuer_name, :cert_username, :public_key_data],
      map_present: [:ttl]
  end
  module Akeyless
    include DataAkeylessSshCertificate
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
