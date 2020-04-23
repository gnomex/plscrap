require 'rails_helper'

RSpec.describe CamaraNhScrapper, type: :service do
  let(:instance) { described_class.new }

  before do
    allow(described_class).to receive(:new).and_return(instance)
  end

  describe '.extract_data' do
    subject { described_class.extract_data }

    before do
      allow(instance).to receive(:extract_with_pagination)
    end

    it 'creates an instance' do
      expect(described_class).to receive(:new)

      subject
    end

    it 'calls extract_with_pagination on instance' do
      expect(instance).to receive(:extract_with_pagination)

      subject
    end
  end

  describe '#extract_with_pagination', :vcr  do
    subject { instance.extract_with_pagination }

    it 'MUST crawl get all 92 records' do
      data = subject

      expect(data.entries.size).to eq(92)
    end
  end

end
