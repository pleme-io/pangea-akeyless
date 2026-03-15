# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/data_akeyless_role/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module DataAkeylessRole
    include Pangea::Resources::ResourceBuilder

    define_data :akeyless_role,
      attributes_class: Akeyless::Types::RoleDataAttributes,
      outputs: { rules: :rules, audit_access: :audit_access, analytics_access: :analytics_access },
      map: [:name]
  end
  module Akeyless
    include DataAkeylessRole
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
