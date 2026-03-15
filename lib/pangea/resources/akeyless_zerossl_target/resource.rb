# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_zerossl_target/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessZerosslTarget
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_zerossl_target,
      attributes_class: Akeyless::Types::ZerosslTargetAttributes,
      outputs: { id: :id, name: :name },
      map: [:name, :api_key_, :imap_username, :imap_fqdn],
      map_present: [:imap_password, :imap_port, :imap_target_email, :key, :description]
  end
  module Akeyless
    include AkeylessZerosslTarget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
