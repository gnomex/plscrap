class CamaraNhScrapper
  URL = "https://sapl.camaranh.rs.gov.br/materia/pesquisar-materia?tipo=1&ementa=&numero=&numeracao__numero_materia=&numero_protocolo=&ano=2019&o=&tipo_listagem=1&data_apresentacao_0=&data_apresentacao_1=&data_publicacao_0=&data_publicacao_1=&autoria__autor=&autoria__primeiro_autor=1&autoria__autor__tipo=&autoria__autor__parlamentar_set__filiacao__partido=&relatoria__parlamentar_id=&local_origem_externa=&tramitacao__unidade_tramitacao_destino=&tramitacao__status=&em_tramitacao=&materiaassunto__assunto=&indexacao="

  def initialize
    @mechanized = Mechanize.new
    @data = ScrapingEntries.new
  end

  def self.extract_data
    new.extract_with_pagination
  end

  def extract_with_pagination
    loop do
      load_page

      get_current_page_content

      break if no_more_pages?
    end

    data
  end

  private

  attr_reader :page, :html, :mechanized, :current_uri, :data

  def load_page
    @page = @mechanized.get(current_uri || URL)
    @html = Nokogiri::HTML(page.body)
  end

  def no_more_pages?
    last_li_element = pagination.last
    li_a_child = last_li_element.xpath('./a')

    @current_uri = mechanized.resolve(li_a_child.first["href"])

    last_li_element.classes.include? "disabled"
  end

  def pagination
    html.xpath('//ul[contains(@class, "pagination")]/li')
  end

  def get_current_page_content
    html.xpath('//table/tr/td').each do |entry|
      a = entry.xpath('./strong/a').first
      link = mechanized.resolve(a.attributes["href"].value)

      subject = {
        name: a.content.split('-').first.strip,
        link: link.to_s,
        description: entry.xpath('./div[@class="dont-break-out"]').text
      }

      data.add(subject)
    end
  end
end
