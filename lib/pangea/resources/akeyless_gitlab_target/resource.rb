# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_gitlab_target/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessGitlabTarget
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_gitlab_target,
      attributes_class: Akeyless::Types::GitlabTargetAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:gitlab_access_token, :gitlab_certificate, :gitlab_url, :key, :description]
  end
  module Akeyless
    include AkeylessGitlabTarget
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
