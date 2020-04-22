class ScrapingService
  def self.scrap_camara_nh
    new.extract_and_persist_data
  end

  def extract_and_persist_data
    scraped_data.entries.each do |pl|
      LawProject.where(name: pl[:name]).first_or_create(pl)
    end
  end

  private

  def scraped_data
    @scraped_data ||= CamaraNhScrapper.extract_data
  end
end
