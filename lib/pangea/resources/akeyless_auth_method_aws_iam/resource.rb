# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_auth_method_aws_iam/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessAuthMethodAwsIam
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_auth_method_aws_iam,
      attributes_class: Akeyless::Types::AuthMethodAwsIamAttributes,
      outputs: { id: :id, access_id: :access_id },
      map: [:name],
      map_present: [:access_expires, :jwt_ttl, :sts_url, :delete_protection],
      map_bool: [:force_sub_claims] do |r, attrs|
        r.bound_aws_account_id attrs.bound_aws_account_id if attrs.bound_aws_account_id.any?
        r.bound_ips attrs.bound_ips if attrs.bound_ips.any?
        r.bound_arn attrs.bound_arn if attrs.bound_arn.any?
        r.bound_role_name attrs.bound_role_name if attrs.bound_role_name.any?
        r.bound_role_id attrs.bound_role_id if attrs.bound_role_id.any?
        r.bound_resource_id attrs.bound_resource_id if attrs.bound_resource_id.any?
        r.bound_user_name attrs.bound_user_name if attrs.bound_user_name.any?
        r.bound_user_id attrs.bound_user_id if attrs.bound_user_id.any?
        r.audit_logs_claims attrs.audit_logs_claims if attrs.audit_logs_claims.any?
      end
  end
  module Akeyless
    include AkeylessAuthMethodAwsIam
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
