require 'date'

class AppendNewPriceJobs < ApplicationJob
  queue_as :default

  def perform
    url = 'https://www.foodcoop.com/produce/'
    results = PriceParser.new(url: url)
    results.iterate do |result|
      ProducePrice.update_or_create(
        date: DateTime.now.strftime('%Y-%m-%d'),
        label: result.label,
        price: result.price,
        unit: result.unit
      )
    end
  end
end
