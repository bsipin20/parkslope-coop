class ProducePricePresenter

  DATE = 'date'
  LABEL = 'label'
  PRICE = 'price'

  def initialize(input, items: nil)
    @produce_prices = input
    @response = {}
    @response[:items] = items
    @response[:prices] = []
  end

  def show
    timeline.to_json
  end

  private

  def timeline
    @produce_prices.all.each do |row| 
      record = {}
      record[DATE] = row[DATE]
      record[row[LABEL]] = row[PRICE].to_f
      @response[:prices].append(record)
    end
    @response
  end
end
