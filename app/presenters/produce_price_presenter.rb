class ProducePricePresenter

  DATE = 'date'
  LABEL = 'label'
  PRICE = 'price'

  def initialize(input)
    @produce_prices = input
    @response = []
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
      @response.append(record)
    end
    @response
  end
end
