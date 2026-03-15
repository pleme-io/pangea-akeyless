# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_github_target/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGithubTarget
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_github_target,
      attributes_class: Akeyless::Types::GithubTargetAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:github_app_id, :github_app_private_key, :github_base_url, :key, :description]
  end
  module Akeyless
    include AkeylessGithubTarget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
