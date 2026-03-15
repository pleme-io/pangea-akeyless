# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_producer_tmp_creds/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessProducerTmpCreds
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_producer_tmp_creds,
      attributes_class: Akeyless::Types::ProducerTmpCredsDataAttributes,
      outputs: { data: :data },
      map: [:name]
  end
  module Akeyless
    include DataAkeylessProducerTmpCreds
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
