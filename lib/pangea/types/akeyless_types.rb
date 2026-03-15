# frozen_string_literal: true

require 'dry-types'
require 'pangea/resources/types'

module Pangea
  module Resources
    module Akeyless
      # Provider-specific Dry::Types for Akeyless resources.
      # Individual resource types.rb files define Dry::Struct classes that
      # reference these via T = Pangea::Resources::Akeyless::Types.
      module Types
        include Dry.Types()

        T = ::Pangea::Resources::Types

        # Constrained enums — used by resources that need validation

        # Classic key algorithms (akeyless_classic_key)
        ClassicKeyAlgorithm = T::String.constrained(
          included_in: %w[
            AES128GCM AES256GCM AES128SIV AES256SIV AES128CBC AES256CBC
            RSA1024 RSA2048 RSA3072 RSA4096 EC256 EC384 GPG
          ]
        )

        # DFC key algorithms — no EC/GPG (akeyless_dfc_key)
        DfcKeyAlgorithm = T::String.constrained(
          included_in: %w[
            AES128GCM AES256GCM AES128SIV AES256SIV AES128CBC AES256CBC
            RSA1024 RSA2048 RSA3072 RSA4096
          ]
        )

        # Database types for akeyless_db_target
        DbType = T::String.constrained(
          included_in: %w[mysql mssql postgres mongodb snowflake oracle cassandra redshift]
        )

        # Certificate formats for akeyless_certificate
        CertificateFormat = T::String.constrained(
          included_in: %w[pem der cer crt pfx p12]
        )

        # Static secret types for akeyless_static_secret
        StaticSecretType = T::String.constrained(
          included_in: %w[generic password]
        ).default("generic")

        # Static secret formats
        StaticSecretFormat = T::String.constrained(
          included_in: %w[text json base64]
        ).default("text")
      end
    end
  end
end
