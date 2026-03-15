# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_dynamic_secret_aws/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessDynamicSecretAws
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_dynamic_secret_aws,
      attributes_class: Akeyless::Types::DynamicSecretAwsAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:target_name, :aws_access_key_id, :aws_access_secret_key, :access_mode, :region,
                    :aws_user_policies, :aws_user_groups, :aws_role_arns, :user_ttl, :password_length,
                    :encryption_key_name, :custom_username_template, :secure_access_enable,
                    :secure_access_aws_account_id, :secure_access_bastion_issuer, :secure_access_url,
                    :secure_access_aws_region],
      map_bool: [:aws_user_console_access, :aws_user_programmatic_access, :secure_access_aws_native_cli,
                 :secure_access_web_browsing, :secure_access_web] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessDynamicSecretAws
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
