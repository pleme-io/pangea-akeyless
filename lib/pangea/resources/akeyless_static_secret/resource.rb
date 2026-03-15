# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_static_secret/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessStaticSecret
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_static_secret,
      attributes_class: Akeyless::Types::StaticSecretAttributes,
      outputs: { id: :id, path: :path, version: :version },
      map: [:path],
      map_present: [:type, :value, :format, :description, :username, :password,
                    :protection_key, :keep_prev_version, :delete_protection,
                    :secure_access_enable, :secure_access_ssh_creds, :secure_access_url,
                    :secure_access_bastion_issuer, :secure_access_ssh_user, :ignore_cache],
      map_bool: [:multiline_value, :secure_access_web_browsing, :secure_access_web] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
        r.inject_url attrs.inject_url if attrs.inject_url.any?
        r.secure_access_host attrs.secure_access_host if attrs.secure_access_host.any?
        if attrs.custom_field.any?
          attrs.custom_field.each do |k, v|
            r.custom_field do
              public_send(k, v)
            end
          end
        end
      end
  end
  module Akeyless
    include AkeylessStaticSecret
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
