# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_role/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessRole
    def akeyless_role(name, attributes = {})
      attrs = Akeyless::Types::RoleAttributes.new(attributes)

      resource(:akeyless_role, name) do
        self.name attrs.name
        description attrs.description if attrs.description
        audit_access attrs.audit_access if attrs.audit_access
        analytics_access attrs.analytics_access if attrs.analytics_access
        gw_analytics_access attrs.gw_analytics_access if attrs.gw_analytics_access
        sra_reports_access attrs.sra_reports_access if attrs.sra_reports_access
        usage_reports_access attrs.usage_reports_access if attrs.usage_reports_access
        event_center_access attrs.event_center_access if attrs.event_center_access
        event_forwarders_access attrs.event_forwarders_access if attrs.event_forwarders_access
        delete_protection attrs.delete_protection if attrs.delete_protection

        attrs.rules.each do |rule|
          rules do
            capability rule[:capability]
            path rule[:path]
            rule_type rule[:rule_type] if rule[:rule_type]
          end
        end

        attrs.assoc_auth_method.each do |assoc|
          assoc_auth_method do
            am_name assoc[:am_name]
            case_sensitive assoc[:case_sensitive] if assoc[:case_sensitive]
            if assoc[:sub_claims]&.any?
              sub_claims do
                assoc[:sub_claims].each { |k, v| public_send(k, v) }
              end
            end
          end
        end
      end

      ResourceReference.new(
        type: 'akeyless_role',
        name: name,
        resource_attributes: attrs.to_h,
        outputs: { id: "${akeyless_role.#{name}.id}", name: "${akeyless_role.#{name}.name}" }
      )
    end
  end
  module Akeyless
    include AkeylessRole
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
