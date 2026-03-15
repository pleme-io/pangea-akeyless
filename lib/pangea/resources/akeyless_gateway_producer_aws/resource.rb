# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gateway_producer_aws/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGatewayProducerAws
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gateway_producer_aws,
      attributes_class: Akeyless::Types::GatewayProducerAwsAttributes,
      outputs: { id: :id },
      map: [:name],
      map_present: [:target_name, :user_ttl, :producer_encryption_key_name,
                    :aws_access_key_id, :aws_access_secret_key, :access_mode, :region,
                    :aws_user_policies, :aws_user_groups, :aws_role_arns],
      map_bool: [:aws_user_console_access, :aws_user_programmatic_access] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessGatewayProducerAws
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
