# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PangeaAkeyless do
  describe 'VERSION' do
    it 'is defined' do
      expect(defined?(PangeaAkeyless::VERSION)).to eq('constant')
    end

    it 'follows semver format' do
      expect(PangeaAkeyless::VERSION).to match(/\A\d+\.\d+\.\d+\z/)
    end

    it 'is a frozen string' do
      expect(PangeaAkeyless::VERSION).to be_frozen
    end
  end
end
