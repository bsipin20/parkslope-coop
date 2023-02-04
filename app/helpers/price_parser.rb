require 'nokogiri'
require 'open-uri'

class PriceParser
  PriceEntry  = Struct.new(:label, :price, :unit)

  attr_reader :url

  def initialize(url:)
    @url = url
  end

  def fetch_rows
    html = Nokogiri::HTML(URI.open(url))
    html.css("tbody tr")
  end

  def iterate(&_block)
    fetch_rows.each do |row|
      label = row.css("td")[0].content.split("\n")[1].strip
      split_item = row.css("td")[1].content.split(" ")
      price = split_item[0][1..-1].to_f
      unit = split_item[1]
      entry = PriceEntry.new(
        label,
        price,
        unit
      )
      yield entry
    end
  end
end
