# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_reset_access_key/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessResetAccessKey
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_reset_access_key,
      attributes_class: Akeyless::Types::ResetAccessKeyDataAttributes,
      outputs: { access_key: :access_key },
      map: [:access_id]
  end
  module Akeyless
    include DataAkeylessResetAccessKey
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
