# pangea-akeyless

Akeyless provider resources for the Pangea infrastructure DSL. Wraps the
`akeyless-community/akeyless` Terraform provider (v1.11.6) as typed Ruby
functions with Dry::Struct validation and terraform-synthesizer output.

## Structure

```
lib/
  pangea-akeyless.rb           # Entry point (requires all resources)
  pangea-akeyless/version.rb   # Version constant
  pangea/
    types/akeyless_types.rb    # Provider-specific Dry::Types
    resources/
      akeyless.rb              # Aggregator module (includes all resources)
      akeyless_*/              # 117 resource directories
        types.rb               # Dry::Struct attributes class
        resource.rb            # ResourceBuilder DSL or manual method
      data_akeyless_*/         # 22 data source directories
        types.rb
        resource.rb
```

## Resource count

- **117 resources** (auth methods, roles, secrets, keys, targets, dynamic secrets,
  rotated secrets, gateway config, producers, log forwarding, event forwarders)
- **22 data sources** (secret lookups, certificate retrieval, auth, etc.)

## Patterns

### ResourceBuilder (most resources)

```ruby
module Pangea::Resources
  module AkeylessStaticSecret
    include Pangea::Resources::ResourceBuilder

    define_resource :akeyless_static_secret,
      attributes_class: Akeyless::Types::StaticSecretAttributes,
      outputs: { id: :id, path: :path, version: :version },
      map: [:path],
      map_present: [:value, :description, :type, :format],
      map_bool: [:multiline_value] do |r, attrs|
      r.tags attrs.tags if attrs.tags.any?
    end
  end
  module Akeyless
    include AkeylessStaticSecret
  end
end
```

### Manual method (complex nested blocks)

`akeyless_role` uses a manual method for `rules` and `assoc_auth_method` nested blocks.
Gateway config resources (`akeyless_gateway_update_*`) use manual methods since they
don't have a `name` attribute in the Terraform schema.

### Data sources

Data sources use `data(:akeyless_xxx, name)` instead of `resource(:akeyless_xxx, name)`.

## Testing

```sh
bundle exec rspec                     # Run all tests
bundle exec rspec spec/resources/akeyless_static_secret/  # Single resource
```

## Dependencies

- pangea-core ~> 0.2
- terraform-synthesizer ~> 0.0.28
- dry-types ~> 1.7
- dry-struct ~> 1.6

## Adding a new resource

1. Create `lib/pangea/resources/akeyless_new_resource/{types.rb,resource.rb}`
2. Add `require_relative` to `lib/pangea-akeyless.rb`
3. Add `include` to `lib/pangea/resources/akeyless.rb`
4. Add spec to `spec/resources/akeyless_new_resource/synthesis_spec.rb`
