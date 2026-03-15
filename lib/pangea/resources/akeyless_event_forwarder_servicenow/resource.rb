# frozen_string_literal: true

require 'pangea/resources/base'
require 'pangea/resources/reference'
require 'pangea/resources/akeyless_event_forwarder_servicenow/types'
require 'pangea/resource_registry'

module Pangea::Resources
  module AkeylessEventForwarderServicenow
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_event_forwarder_servicenow,
      attributes_class: Akeyless::Types::EventForwarderServicenowAttributes,
      outputs: { id: :id, name: :name },
      map: [:name],
      map_present: [:description, :host, :auth_type, :client_id, :client_secret, :runner_type] do |r, attrs|
        r.event_types attrs.event_types if attrs.event_types.any?
      end
  end
  module Akeyless
    include AkeylessEventForwarderServicenow
  end
end
Pangea::ResourceRegistry.register_module(Pangea::Resources::Akeyless)
