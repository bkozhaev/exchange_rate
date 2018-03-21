require 'net/http'
require 'uri'
require 'rexml/document'
require_relative 'lib/currency'
require_relative 'lib/currency_collection'

uri = URI.parse("https://www.cbr-xml-daily.ru/daily_utf8.xml")
response = Net::HTTP.get_response(uri)
doc = REXML::Document.new(response.body)

all_currency = doc.root.to_a

currency_collection = CurrencyCollection.from_nodes(Currency, all_currency)

usd_value = nil

currency_collection.collection.each do |currency|
  usd_value = currency.value if currency.name.include?('Доллар США')
end

puts "Какая у вас на руках валюта?"

puts "\n1. Рубли"

puts "\n2. Доллары"

currency = STDIN.gets.chomp.to_i

while ![1,2].include?(currency)
  puts "\nПожалуйста введите цифру 1 для рублей и 2 для доллара"
  currency = STDIN.gets.chomp.to_i
end

if currency == 1
  rub_to_usd = (1/usd_value.tr(',','.').to_f).round(3)

  puts "\n1 рубль стоит: #{rub_to_usd} USD"

  puts "\nСколько у вас рублей?"

  currency_amount = STDIN.gets.chomp.to_f

  puts "\nВаши запасы на сегдня равны: $#{(currency_amount * rub_to_usd).round(2)}"

elsif currency == 2


  rub_to_usd = usd_value.tr(',','.').to_f.round(3)
  puts "\n1 доллар стоит #{rub_to_usd} руб."

  puts "\nСколько у вас долларов?"

  currency_amount = STDIN.gets.chomp.to_f

  puts "\nВаши запасы на сегдня равны: #{(currency_amount * rub_to_usd).round(2)} руб."
end

