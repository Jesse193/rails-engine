require "rails_helper"

describe "items api" do
  xit "can find a item by keyword" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    item_1 = Item.create(name: "Computer", description: "Computer fo special tasks", unit_price: 1000, merchant_id: merchant_1.id)
    item_2 = Item.create(name: "Phone", description: "Phone", unit_price: 950, merchant_id: merchant_2.id)
    GET "/api/v1/merchants/find?name=Computer"

    fill_in :search, with: "Computer"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:name]).to eq("computer")
    expect(merchant[:data][:description]).to eq("Computer fo special tasks")
    expect(merchant[:data][:unit_price].to eq(1000))
  end
end