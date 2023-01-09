class ProducePriceController < ApplicationController

  def index
    prices = ProducePrice.search(params[:search])
    render json: ProducePricePresenter.new(prices).show
  end

  private
end
