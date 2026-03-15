# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_kube_exec_creds/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessKubeExecCreds
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_kube_exec_creds,
      attributes_class: Akeyless::Types::KubeExecCredsDataAttributes,
      outputs: {
        client_certificate: :client_certificate,
        client_key: :client_key,
        token: :token,
        expiration_timestamp: :expiration_timestamp
      },
      map: [:cert_issuer_name],
      map_present: [:key_file_path, :common_name, :alt_names, :uri_sans]
  end
  module Akeyless
    include DataAkeylessKubeExecCreds
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
