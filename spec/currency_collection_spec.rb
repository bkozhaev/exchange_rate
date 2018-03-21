require 'rspec'
require_relative '../lib/currency_collection'
require_relative '../lib/currency'
require_relative '../exchange'

describe '.check_currency' do
  let(:currency_collection) do
    uri = URI.parse("https://www.cbr-xml-daily.ru/daily_utf8.xml")
    response = Net::HTTP.get_response(uri)
    doc = REXML::Document.new(response.body)

    all_currency = doc.root.to_a

    CurrencyCollection.from_nodes(Currency, all_currency)
  end
  it 'should return true' do
    expect(currency_collection.check_currency?('Австралийский доллар')).to eq(true)
  end
end