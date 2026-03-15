# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_ssh_cert_issuer/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessSshCertIssuer
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_ssh_cert_issuer,
      attributes_class: Akeyless::Types::SshCertIssuerAttributes,
      outputs: { id: :id, name: :name },
      map: [:name, :signer_key_name, :allowed_users, :ttl],
      map_present: [:principals, :description, :secure_access_enable,
                    :secure_access_bastion_api, :secure_access_bastion_ssh,
                    :secure_access_ssh_creds_user],
      map_bool: [:secure_access_use_internal_bastion, :delete_protection] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
        r.secure_access_host attrs.secure_access_host if attrs.secure_access_host.any?
        if attrs.extensions.any?
          r.extensions do
            attrs.extensions.each { |k, v| public_send(k, v) }
          end
        end
      end
  end
  module Akeyless
    include AkeylessSshCertIssuer
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
