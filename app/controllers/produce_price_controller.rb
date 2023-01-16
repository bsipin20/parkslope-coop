class ProducePriceController < ApplicationController

  def index
    prices = ProducePrice.search(params[:search])
    render json: ProducePricePresenter.new(prices).show
  rescue ArgumentError => e
    render :json => { :status => 422, :errors => e.message }
  end
end
