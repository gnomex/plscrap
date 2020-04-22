class ScrapingEntries
  def initialize
    @elements = Array.new
  end

  def add(data)
    @elements.push ScrapedData.new(data)
  end

  def entries
    @elements.flat_map(&:attributes)
  end
end
