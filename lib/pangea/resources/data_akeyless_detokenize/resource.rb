# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_detokenize/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessDetokenize
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_detokenize,
      attributes_class: Akeyless::Types::DetokenizeDataAttributes,
      outputs: { result: :result },
      map: [:tokenizer_name, :ciphertext]
  end
  module Akeyless
    include DataAkeylessDetokenize
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
