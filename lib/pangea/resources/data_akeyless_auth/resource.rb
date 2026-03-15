# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_auth/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessAuth
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_auth,
      attributes_class: Akeyless::Types::AuthDataAttributes,
      outputs: { token: :token, admin_token: :admin_token },
      map: [:access_id],
      map_present: [:access_key, :access_type, :admin_email, :admin_password]
  end
  module Akeyless
    include DataAkeylessAuth
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
