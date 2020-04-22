class ScrapingService
  def self.scrap_camara_nh
    new.scrap_camara_nh
  end

  def scrap_camara_nh
    pls = CamaraNhScrapper.do_scraping

    pls.each do |pl|
      LawProject.where(name: pl[:name]).first_or_create(pl)
    end
  end
end
