require "rails_helper"

describe "items api" do
  describe "can find a item by keyword" do
    it "happy path" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      item_1 = Item.create(name: "Computer", description: "Computer for special tasks", unit_price: 1000, merchant_id: merchant_1.id)
      item_2 = Item.create(name: "Phone", description: "Phone", unit_price: 950, merchant_id: merchant_2.id)
      item_3 = Item.create(name: "Computer 2.0", description: "Computer for even more special tasks", unit_price: 1500, merchant_id: merchant_1.id)

      get "/api/v1/items/find_all?name=Computer"
      items = JSON.parse(response.body, symbolize_names: true)
      expect(items[:data][0][:attributes][:name]).to eq("Computer")
      expect(items[:data][0][:attributes][:description]).to eq("Computer for special tasks")
      expect(items[:data][0][:attributes][:unit_price]).to eq(1000)
      expect(items[:data][1][:attributes][:name]).to eq("Computer 2.0")
      expect(items[:data][1][:attributes][:description]).to eq("Computer for even more special tasks")
      expect(items[:data][1][:attributes][:unit_price]).to eq(1500)
    end
    it "sad path" do
      get "/api/v1/items/find_all?name=dogs"
      item = JSON.parse(response.body, symbolize_names: true)
      expect(item[:data]).to eq([])
    end
  end
end