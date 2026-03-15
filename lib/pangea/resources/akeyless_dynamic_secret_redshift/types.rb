# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class DynamicSecretRedshiftAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :target_name, T::String.optional
    attribute? :redshift_db_name, T::String.optional
    attribute? :redshift_username, T::String.optional
    attribute? :redshift_password, T::String.optional
    attribute? :redshift_host, T::String.optional
    attribute :redshift_port, T::String.default('5439')
    attribute? :creation_statements, T::String.optional
    attribute :user_ttl, T::String.default('60m')
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute? :encryption_key_name, T::String.optional
    attribute? :ssl, T::Bool.optional
    attribute? :ssl_certificate, T::String.optional
  end
end
