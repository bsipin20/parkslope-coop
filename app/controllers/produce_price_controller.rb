class ProducePriceController < ApplicationController

  def index
    prices = ProducePrice.search(params[:search])
    items = prices.pluck(:label)
    render json: ProducePricePresenter.new(prices, items: items).show
  rescue ArgumentError => e
    render :json => { :status => 422, :errors => e.message }
  end
end
