# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_auth_method_k8s/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessAuthMethodK8s
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_auth_method_k8s,
      attributes_class: Akeyless::Types::AuthMethodK8sAttributes,
      outputs: { id: :id, access_id: :access_id, private_key: :private_key },
      map: [:name],
      map_present: [:access_expires, :jwt_ttl, :gen_key, :audience, :public_key, :delete_protection],
      map_bool: [:force_sub_claims] do |r, attrs|
        r.bound_ips attrs.bound_ips if attrs.bound_ips.any?
        r.bound_sa_names attrs.bound_sa_names if attrs.bound_sa_names.any?
        r.bound_pod_names attrs.bound_pod_names if attrs.bound_pod_names.any?
        r.bound_namespaces attrs.bound_namespaces if attrs.bound_namespaces.any?
        r.audit_logs_claims attrs.audit_logs_claims if attrs.audit_logs_claims.any?
      end
  end
  module Akeyless
    include AkeylessAuthMethodK8s
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
