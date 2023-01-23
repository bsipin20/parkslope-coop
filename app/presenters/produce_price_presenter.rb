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
    last_label = "START"
    curr_item = {}
    ordered = @produce_prices.order(:label, date: :asc)
    ordered.each do |row|
      if row[LABEL] != last_label
        @response[:prices].append(curr_item) if !curr_item.empty?
        curr_item = {}
        curr_item[UNIT] = parse_label(row[UNIT])
        curr_item[LABEL] = row[LABEL]
        curr_item[PRICE+'s'] = [row[PRICE]]
        curr_item[DATE+'s'] = [row[DATE]]
        last_label = row[LABEL]
      else
        curr_item[PRICE+'s'].append(row[PRICE])
        curr_item[DATE+'s'].append(row[DATE])
        last_label = row[LABEL]
      end
    end
    @response[:prices].append(curr_item)
    @response
  end

  def parse_label(row_unit_label)
    if row_unit_label == "per pound"
      "lb"
    else
      row_unit_label
    end
  end
end
