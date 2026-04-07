# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'ResourceReference integration' do
  include Pangea::Testing::SynthesisTestHelpers

  let(:synth) { create_synthesizer }

  before { synth.extend(Pangea::Resources::Akeyless) }

  describe 'output interpolation' do
    it 'generates correct Terraform interpolation for id output' do
      ref = synth.akeyless_folder(:my_folder, name: '/test')
      expect(ref.outputs[:id]).to eq('${akeyless_folder.my_folder.id}')
    end

    it 'generates correct Terraform interpolation for name output' do
      ref = synth.akeyless_folder(:my_folder, name: '/test')
      expect(ref.outputs[:name]).to eq('${akeyless_folder.my_folder.name}')
    end

    it 'preserves resource type in reference' do
      ref = synth.akeyless_static_secret(:sec, name: '/s', value: 'v')
      expect(ref.type).to eq('akeyless_static_secret')
    end

    it 'preserves resource name in reference' do
      ref = synth.akeyless_role(:r, name: '/role')
      expect(ref.name).to eq(:r)
    end
  end

  describe 'resource_attributes' do
    it 'stores validated attributes in the reference' do
      ref = synth.akeyless_folder(:f, name: '/folder', description: 'desc')
      expect(ref.resource_attributes[:name]).to eq('/folder')
      expect(ref.resource_attributes[:description]).to eq('desc')
    end

    it 'stores nil for unset optional attributes' do
      ref = synth.akeyless_folder(:f, name: '/folder')
      expect(ref.resource_attributes[:description]).to be_nil
    end
  end

  describe 'ref method' do
    it 'generates arbitrary attribute references' do
      ref = synth.akeyless_folder(:f, name: '/folder')
      expect(ref.ref(:self_link)).to eq('${akeyless_folder.f.self_link}')
    end

    it 'generates id reference via convenience method' do
      ref = synth.akeyless_folder(:f, name: '/folder')
      expect(ref.id).to eq('${akeyless_folder.f.id}')
    end
  end

  describe 'cross-resource references' do
    it 'allows one resource to reference another' do
      folder_ref = synth.akeyless_folder(:parent, name: '/parent')

      secret_ref = synth.akeyless_static_secret(:child,
        name: '/parent/child',
        value: 'secret'
      )

      result = normalize_synthesis(synth.synthesis)
      expect(result.dig('resource', 'akeyless_folder', 'parent')).not_to be_nil
      expect(result.dig('resource', 'akeyless_static_secret', 'child')).not_to be_nil

      expect(folder_ref.outputs[:id]).to include('akeyless_folder.parent.id')
      expect(secret_ref.outputs[:id]).to include('akeyless_static_secret.child.id')
    end
  end
end
