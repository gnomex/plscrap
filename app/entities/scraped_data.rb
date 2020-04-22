class ScrapedData
  attr_reader :name, :link, :description

  def initialize(args)
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  def attributes
    {
      name: name,
      link: link,
      description: description
    }.with_indifferent_access
  end
end
