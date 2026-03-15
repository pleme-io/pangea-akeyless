# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_tokenize/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessTokenize
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_tokenize,
      attributes_class: Akeyless::Types::TokenizeDataAttributes,
      outputs: { result: :result },
      map: [:tokenizer_name, :plaintext]
  end
  module Akeyless
    include DataAkeylessTokenize
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
