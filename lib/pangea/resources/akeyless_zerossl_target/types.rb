# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class ZerosslTargetAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute :api_key_, T::String
    attribute :imap_username, T::String
    attribute? :imap_password, T::String.optional
    attribute :imap_fqdn, T::String
    attribute :imap_port, T::String.default('993')
    attribute? :imap_target_email, T::String.optional
    attribute? :key, T::String.optional
    attribute? :description, T::String.optional
  end
end
