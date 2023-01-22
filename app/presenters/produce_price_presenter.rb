class ProducePricePresenter

  DATE = 'date'
  LABEL = 'label'
  PRICE = 'price'
  UNIT = 'unit'

  def initialize(input, items: nil)
    @produce_prices = input
    @items = items
    @response = {}
    @response[:prices] = []
  end

  def show
    timeline.to_json
  end

  private

  def timeline
    @items.each do |item|
      prices = []
      dates = []
      units = []
      record = {}

      @produce_prices.all.where(label: item).each do |row|
        prices.append(row[PRICE])
        dates.append(row[DATE])
        units.append(unit_label(row[UNIT]))
      end

      record[LABEL] = item
      record[DATE+'s'] = dates
      record[PRICE+'s'] = prices
      record[UNIT+'s'] = units
      @response[:prices].append(record)
    end
    @response
  end

  def unit_label(row_unit_label)
    if row_unit_label == "each"
      "each"
    elsif row_unit_label == "per pound"
      "lb"
    end
  end
end
