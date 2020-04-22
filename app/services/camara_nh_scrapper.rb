class CamaraNhScrapper
  URL = "https://sapl.camaranh.rs.gov.br/materia/pesquisar-materia?tipo=1&ementa=&numero=&numeracao__numero_materia=&numero_protocolo=&ano=2019&o=&tipo_listagem=1&data_apresentacao_0=&data_apresentacao_1=&data_publicacao_0=&data_publicacao_1=&autoria__autor=&autoria__primeiro_autor=1&autoria__autor__tipo=&autoria__autor__parlamentar_set__filiacao__partido=&relatoria__parlamentar_id=&local_origem_externa=&tramitacao__unidade_tramitacao_destino=&tramitacao__status=&em_tramitacao=&materiaassunto__assunto=&indexacao="

  def initialize
    @mechanized = Mechanize.new
    @page = @mechanized.get(URL)
    @html = Nokogiri::HTML(page.body)
  end

  def self.scrap
    new.scrap
  end

  def paginated_scrap
    result = []

    loop do
      result.push scrap

      break unless has_more_pages
    end

    binding.pry

    result.flatten
  end

  def has_more_pages
    a = html.css('.pagination')
    b = a.xpath('./li')
    c = b.last.xpath('./a')
    link = mechanized.resolve(c.first["href"])

    # TODO: finalize pagination

    return if b.last.classes.include? "disabled"

    @page = mechanized.get(link.to_s)

    true
  end

  def scrap
    html.xpath('//table/tr/td').each_with_object([]) do |entry, result|
      a = entry.xpath('./strong/a').first
      link = mechanized.resolve(a.attributes["href"].value)

      subject = {
        name: a.content,
        link: link.to_s,
        description: entry.xpath('./div[@class="dont-break-out"]').text
      }

      result.push(subject)
    end
  end

  private

  attr_reader :page, :html, :mechanized

end
