class CurrencyCollection
  attr_reader :collection, :currency_names

  def self.from_nodes(currency, nodes)
    currencies = []

    nodes.each { |node| currencies << currency.from_nod(node) }

    new(currencies)
  end

  def initialize(collection = [])
    @collection = collection
    @currency_names = collect_currency_names
  end

  def collect_currency_names
    collection = []
    @collection.each { |currency| collection << currency.name }
    collection
  end

  def check_currency?(name) #name of a currency etc Австралийский доллар
    @currency_names.map do |item|
      item.downcase.include?(name.downcase)
    end.include?(true)
  end
end