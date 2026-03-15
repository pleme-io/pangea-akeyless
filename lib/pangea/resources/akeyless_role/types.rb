# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class RoleAssocAuthMethod < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :am_name, T::String
    attribute :sub_claims, T::Hash.map(T::String, T::String).default({}.freeze)
    attribute :case_sensitive, T::String.default("true")
  end

  class RoleRule < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :capability, T::Array.of(T::String)
    attribute :path, T::String
    attribute :rule_type, T::String.default("item-rule")
  end

  class RoleAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :description, T::String.optional
    attribute? :audit_access, T::String.optional
    attribute? :analytics_access, T::String.optional
    attribute? :gw_analytics_access, T::String.optional
    attribute? :sra_reports_access, T::String.optional
    attribute? :usage_reports_access, T::String.optional
    attribute? :event_center_access, T::String.optional
    attribute? :event_forwarders_access, T::String.optional
    attribute? :delete_protection, T::String.optional
    attribute :assoc_auth_method, T::Array.of(RoleAssocAuthMethod).default([].freeze)
    attribute :rules, T::Array.of(RoleRule).default([].freeze)
  end
end
