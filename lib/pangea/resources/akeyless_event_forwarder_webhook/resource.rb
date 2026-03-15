# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_event_forwarder_webhook/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessEventForwarderWebhook
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_event_forwarder_webhook,
      attributes_class: Akeyless::Types::EventForwarderWebhookAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:description, :url, :auth_type, :auth_token, :runner_type] do |r, attrs|
        r.event_types attrs.event_types if attrs.event_types.any?
      end
  end
  module Akeyless
    include AkeylessEventForwarderWebhook
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
