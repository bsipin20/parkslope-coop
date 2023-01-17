require 'rails_helper'

RSpec.describe ProducePriceController do
  describe "GET index" do
    it "search items" do
      ProducePrice.create(
        label: "Apples",
        date: "2022-10-30",
        price: 5.0,
        unit: "lb"
      )
      ProducePrice.create(
        label: "Apples",
        date: "2022-10-31",
        price: 6.0,
        unit: "lb"
      )

      get :index, params: {search: "Apple"}
      expect(response).to have_http_status(:ok)
      response_body = JSON.parse(response.body)
      expect(response_body.count).to eq(2)
      expect(response_body.first["Apples"]).to eq(5.0)
      expect(response_body.second["Apples"]).to eq(6.0)
    end

    it "search empty string return error" do
      get :index, params: {search: ""}
      response_body = JSON.parse(response.body)
      expect(response_body["status"]).to eq(422)
      expect(response_body["errors"]).to eq("Search string cannot be blank")
    end
  end
end
