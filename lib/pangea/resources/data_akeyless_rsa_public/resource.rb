# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_rsa_public/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessRsaPublic
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_rsa_public,
      attributes_class: Akeyless::Types::RsaPublicDataAttributes,
      outputs: { data: :data, metadata: :metadata },
      map: [:name]
  end
  module Akeyless
    include DataAkeylessRsaPublic
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
