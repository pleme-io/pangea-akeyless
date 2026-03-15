# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_csr/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessCsr
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_csr,
      attributes_class: Akeyless::Types::CsrDataAttributes,
      outputs: { data: :data },
      map: [:name, :common_name],
      map_present: [:country, :organization, :dep, :city, :state,
                    :alt_names, :key_type, :uri_sans, :email_addresses],
      map_bool: [:generate_key]
  end
  module Akeyless
    include DataAkeylessCsr
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
