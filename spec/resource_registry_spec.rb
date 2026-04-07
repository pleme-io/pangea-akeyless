# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Pangea::ResourceRegistry do
  describe '.registered?' do
    it 'reports Akeyless module as registered' do
      expect(described_class.registered?(Pangea::Resources::Akeyless)).to eq(true)
    end
  end

  describe '.registered_modules' do
    it 'includes the Akeyless module' do
      expect(described_class.registered_modules).to include(Pangea::Resources::Akeyless)
    end
  end

  describe '.stats' do
    it 'returns statistics hash' do
      stats = described_class.stats
      expect(stats).to be_a(Hash)
      expect(stats).to have_key(:total_modules)
      expect(stats[:total_modules]).to be >= 1
    end
  end
end
