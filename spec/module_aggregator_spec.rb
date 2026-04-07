# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Pangea::Resources::Akeyless do
  include Pangea::Testing::SynthesisTestHelpers

  it 'is a module' do
    expect(described_class).to be_a(Module)
  end

  it 'includes all auth method modules' do
    expect(described_class.ancestors).to include(Pangea::Resources::AkeylessAuthMethodApiKey)
    expect(described_class.ancestors).to include(Pangea::Resources::AkeylessAuthMethodAwsIam)
    expect(described_class.ancestors).to include(Pangea::Resources::AkeylessAuthMethodOidc)
    expect(described_class.ancestors).to include(Pangea::Resources::AkeylessAuthMethodSaml)
  end

  it 'includes all target modules' do
    expect(described_class.ancestors).to include(Pangea::Resources::AkeylessTargetAws)
    expect(described_class.ancestors).to include(Pangea::Resources::AkeylessTargetDb)
    expect(described_class.ancestors).to include(Pangea::Resources::AkeylessTargetGcp)
    expect(described_class.ancestors).to include(Pangea::Resources::AkeylessTargetSsh)
  end

  it 'includes key modules' do
    expect(described_class.ancestors).to include(Pangea::Resources::AkeylessClassicKey)
    expect(described_class.ancestors).to include(Pangea::Resources::AkeylessDfcKey)
  end

  it 'includes role and policy modules' do
    expect(described_class.ancestors).to include(Pangea::Resources::AkeylessRole)
    expect(described_class.ancestors).to include(Pangea::Resources::AkeylessPolicy)
  end

  it 'includes cert issuer modules' do
    expect(described_class.ancestors).to include(Pangea::Resources::AkeylessPkiCertIssuer)
    expect(described_class.ancestors).to include(Pangea::Resources::AkeylessSshCertIssuer)
  end

  describe 'method availability via synthesizer' do
    let(:synth) { create_synthesizer }

    before { synth.extend(described_class) }

    %i[
      akeyless_folder
      akeyless_role
      akeyless_static_secret
      akeyless_classic_key
      akeyless_dfc_key
      akeyless_policy
      akeyless_auth_method_api_key
      akeyless_target_aws
      akeyless_dynamic_secret_postgresql
      akeyless_pki_cert_issuer
      akeyless_ssh_cert_issuer
      akeyless_event_forwarder_slack
      akeyless_gateway_allowed_access
      akeyless_rotated_secret_aws
    ].each do |resource_method|
      it "responds to #{resource_method}" do
        expect(synth).to respond_to(resource_method)
      end
    end
  end
end
