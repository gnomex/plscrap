class ScrapingService
  def self.scrap_camara_nh
    new.extract_and_persist_data
  end

  def extract_and_persist_data
    scraped_data.entries.each { |pl| find_or_create(pl) }
  end

  private

  def scraped_data
    @scraped_data ||= CamaraNhScrapper.extract_data
  end

  def find_or_create(attrs)
    LawProject.where(name: attrs[:name]).first_or_create(attrs)
  end
end
