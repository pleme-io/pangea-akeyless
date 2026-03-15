# frozen_string_literal: true

require 'dry-struct'
require 'pangea/types/akeyless_types'

module Pangea::Resources::Akeyless::Types
  class GatewayUpdateLogForwardingAwsS3Attributes < Dry::Struct
    transform_keys(&:to_sym)
    T = Pangea::Resources::Akeyless::Types

    attribute? :enable, T::String.optional.default("true")
    attribute? :output_format, T::String.optional
    attribute? :pull_interval, T::String.optional
    attribute? :bucket_name, T::String.optional
    attribute? :region, T::String.optional
    attribute? :aws_access_id, T::String.optional
    attribute? :aws_access_key, T::String.optional
    attribute? :role_arn, T::String.optional
    attribute :log_folder, T::String.default('use-existing')
  end
end
