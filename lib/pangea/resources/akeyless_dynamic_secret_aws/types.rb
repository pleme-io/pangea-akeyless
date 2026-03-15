# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class DynamicSecretAwsAttributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute :name, T::String
    attribute? :target_name, T::String.optional
    attribute? :aws_access_key_id, T::String.optional
    attribute? :aws_access_secret_key, T::String.optional
    attribute :access_mode, T::String.default('iam_user')
    attribute :region, T::String.default('us-east-2')
    attribute? :aws_user_policies, T::String.optional
    attribute? :aws_user_groups, T::String.optional
    attribute? :aws_role_arns, T::String.optional
    attribute :aws_user_console_access, T::Bool.default(false)
    attribute :aws_user_programmatic_access, T::Bool.default(true)
    attribute :user_ttl, T::String.default('60m')
    attribute? :password_length, T::String.optional
    attribute? :encryption_key_name, T::String.optional
    attribute? :custom_username_template, T::String.optional
    attribute :tags, T::Array.of(T::String).default([].freeze)
    attribute? :secure_access_enable, T::String.optional
    attribute? :secure_access_aws_account_id, T::String.optional
    attribute? :secure_access_aws_native_cli, T::Bool.optional
    attribute? :secure_access_web_browsing, T::Bool.optional
    attribute? :secure_access_bastion_issuer, T::String.optional
    attribute? :secure_access_web, T::Bool.optional
    attribute? :secure_access_url, T::String.optional
    attribute? :secure_access_aws_region, T::String.optional
  end
end
