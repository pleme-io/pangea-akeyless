# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_dynamic_secret_gitlab/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessDynamicSecretGitlab
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_dynamic_secret_gitlab,
      attributes_class: Akeyless::Types::DynamicSecretGitlabAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:target_name, :gitlab_access_token, :gitlab_certificate, :gitlab_url,
                    :gitlab_access_type, :gitlab_role, :gitlab_token_scopes, :user_ttl,
                    :encryption_key_name] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessDynamicSecretGitlab
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
