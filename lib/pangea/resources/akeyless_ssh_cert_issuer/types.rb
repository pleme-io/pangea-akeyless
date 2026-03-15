# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class SshCertIssuerAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :signer_key_name, T::String
    attribute :allowed_users, T::String
    attribute :ttl, T::Integer
    attribute? :principals, T::String.optional
    attribute :extensions, T::Hash.map(T::String, T::String).default({}.freeze)
    attribute? :description, T::String.optional
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute? :secure_access_enable, T::String.optional
    attribute? :secure_access_bastion_api, T::String.optional
    attribute? :secure_access_bastion_ssh, T::String.optional
    attribute? :secure_access_ssh_creds_user, T::String.optional
    attribute :secure_access_host, T::Array.of(T::String).default([].freeze)
    attribute? :secure_access_use_internal_bastion, T::Bool.optional
    attribute? :delete_protection, T::Bool.optional
  end
end
