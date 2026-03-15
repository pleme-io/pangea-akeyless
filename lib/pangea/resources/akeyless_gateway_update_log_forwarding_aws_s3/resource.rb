# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_update_log_forwarding_aws_s3/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayUpdateLogForwardingAwsS3
    def akeyless_gateway_update_log_forwarding_aws_s3(name, attributes = {})
      attrs = Akeyless::Types::GatewayUpdateLogForwardingAwsS3Attributes.new(attributes)
      resource(:akeyless_gateway_update_log_forwarding_aws_s3, name) do
        enable attrs.enable if attrs.enable
        output_format attrs.output_format if attrs.output_format
        pull_interval attrs.pull_interval if attrs.pull_interval
        bucket_name attrs.bucket_name if attrs.bucket_name
        region attrs.region if attrs.region
        aws_access_id attrs.aws_access_id if attrs.aws_access_id
        aws_access_key attrs.aws_access_key if attrs.aws_access_key
        role_arn attrs.role_arn if attrs.role_arn
        log_folder attrs.log_folder if attrs.log_folder
      end
      ResourceReference.new(
        type: "akeyless_gateway_update_log_forwarding_aws_s3",
        name: name,
        resource_attributes: attrs.to_h,
        outputs: { id: "${akeyless_gateway_update_log_forwarding_aws_s3.#{name}.id}" }
      )
    end
  end
  module Akeyless
    include AkeylessGatewayUpdateLogForwardingAwsS3
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
