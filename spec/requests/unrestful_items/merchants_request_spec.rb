require "rails_helper"

describe "items api" do
  it "can find a item by keyword" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    item_1 = Item.create(name: "Computer", description: "Computer fo special tasks", unit_price: 1000, merchant_id: merchant_1.id)
    item_2 = Item.create(name: "Phone", description: "Phone", unit_price: 950, merchant_id: merchant_2.id)

    get "/api/v1/merchants/find?name=#{merchant_1.name}"
    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(merchant[:data][0][:attributes][:name]).to eq(merchant_1.name)
  end
end