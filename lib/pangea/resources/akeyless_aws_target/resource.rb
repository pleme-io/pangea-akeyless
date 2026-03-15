# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_aws_target/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessAwsTarget
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_aws_target,
      attributes_class: Akeyless::Types::AwsTargetAttributes,
      outputs: { id: :id, name: :name },
      map: [:name, :access_key_id],
      map_present: [:access_key, :session_token, :region, :key, :description],
      map_bool: [:use_gw_cloud_identity]
  end
  module Akeyless
    include AkeylessAwsTarget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
