require 'rails_helper'

RSpec.describe ScrapingService, type: :service do
  let(:instance) { described_class.new }

  before do
    allow(described_class).to receive(:new).and_return(instance)
  end

  describe '.scrap_camara_nh' do

    subject { described_class.scrap_camara_nh }

    before do
      allow(CamaraNhScrapper).to receive(:extract_data).
        and_return(ScrapingEntries.new)
    end

    it 'creates an instance' do
      expect(described_class).to receive(:new)

      subject
    end

    it 'calls extract_and_persist_data on instance' do
      expect(instance).to receive(:extract_and_persist_data)

      subject
    end
  end

  describe '#extract_and_persist_data' do
    let(:data) { ScrapingEntries.new.tap { |s| s.add({}) } }

    before do
      allow(instance).to receive(:scraped_data).and_return(data)
    end

    subject { instance.extract_and_persist_data }

    context 'with entries' do
      it 'iterate over extract_data and persist entries' do
        expect(instance).to receive(:find_or_create)

        subject
      end
    end

    context 'without entries' do
      let(:data) { ScrapingEntries.new }

      it 'does not iterate' do
        expect(instance).to_not receive(:find_or_create)

        subject
      end
    end

  end
end
