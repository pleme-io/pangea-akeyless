# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_auth_method/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessAuthMethod
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_auth_method,
      attributes_class: Akeyless::Types::AuthMethodDataAttributes,
      outputs: { id: :id, access_id: :access_id, access_date: :access_date },
      map: [:path]
  end
  module Akeyless
    include DataAkeylessAuthMethod
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
