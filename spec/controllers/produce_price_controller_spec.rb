require 'rails_helper'

RSpec.describe ProducePriceController do
  describe "GET index" do
    it "search items" do
      ProducePrice.create(
        label: "Apples-honeycrisp",
        date: "2022-12-30",
        price: 5.0,
        unit: "per pound"
      )
      ProducePrice.create(
        label: "Apples-honeycrisp",
        date: "2022-10-31",
        price: 6.0,
        unit: "per pound"
      )
      ProducePrice.create(
        label: "Apples-fuji",
        date: "2022-10-30",
        price: 3.3,
        unit: "each"
      )
      ProducePrice.create(
        label: "Apples-fuji",
        date: "2022-10-31",
        price: 7.0,
        unit: "each"
      )

      ProducePrice.create(
        label: "Bananas",
        date: "2022-10-31",
        price: 7.0,
        unit: "each"
      )

      get :index, params: {search: "Apple"}
      expect(response).to have_http_status(:ok)
      response_body = JSON.parse(response.body)
      results = response_body['prices']
      expect(results.length).to eq(2)
      expect(results.first["unit"]).to eq("each")
      expect(results.first["label"]).to eq("Apples-fuji")
      expect(results.first["prices"]).to eq(["3.3", "7.0"])
      expect(results.first["date"]).to eq(["2022-10-30", "2022-10-31"])
      expect(results.second["unit"]).to eq("lb")
      expect(results.second["label"]).to eq("Apples-honeycrisp")
      expect(results.second["prices"]).to eq(["6.0", "5.0"])
      expect(results.second["date"]).to eq(["2022-10-31", "2022-12-30"])
    end

    it "search empty string return error" do
      get :index, params: {search: ""}
      response_body = JSON.parse(response.body)
      expect(response_body["status"]).to eq(422)
      expect(response_body["errors"]).to eq("Search string cannot be blank")
    end
  end
end
