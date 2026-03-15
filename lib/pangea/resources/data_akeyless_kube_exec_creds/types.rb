# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class KubeExecCredsDataAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :cert_issuer_name, T::String
    attribute? :key_file_path, T::String.optional
    attribute? :common_name, T::String.optional
    attribute? :alt_names, T::String.optional
    attribute? :uri_sans, T::String.optional
  end
end
