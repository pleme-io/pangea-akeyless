# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_tokenizer/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessTokenizer
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_tokenizer,
      attributes_class: Akeyless::Types::TokenizerAttributes,
      outputs: { id: :id },
      map: [:name, :template_type],
      map_present: [:description, :delete_protection] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessTokenizer
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
