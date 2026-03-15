# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_dynamic_secret_github/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessDynamicSecretGithub
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_dynamic_secret_github,
      attributes_class: Akeyless::Types::DynamicSecretGithubAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:target_name, :github_app_id, :github_app_private_key, :github_base_url,
                    :installation_id, :installation_organization, :github_repository,
                    :token_permissions, :token_repositories, :user_ttl,
                    :encryption_key_name] do |r, attrs|
        r.tags attrs.tags if attrs.tags.any?
      end
  end
  module Akeyless
    include AkeylessDynamicSecretGithub
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
