require "rails_helper"

describe "merchants api" do
  describe "can find a merchant by keyword" do
    it "happy path" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      item_1 = Item.create(name: "Computer", description: "Computer fo special tasks", unit_price: 1000, merchant_id: merchant_1.id)
      item_2 = Item.create(name: "Phone", description: "Phone", unit_price: 950, merchant_id: merchant_2.id)

      get "/api/v1/merchants/find?name=#{merchant_1.name}"
      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(merchant[:data][:attributes][:name]).to eq(merchant_1.name)
    end
    xit "sad path" do
      get "/api/v1/merchants/find?name=dogs"
      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(merchant[:data]).to eq([])
    end
  end

  describe "can find merchant by fragment" do
    it "happy path" do
      merchant_1 = Merchant.create(name: "George Smith")
      merchant_2 = create(:merchant)
      item_1 = Item.create(name: "Computer", description: "Computer fo special tasks", unit_price: 1000, merchant_id: merchant_1.id)
      item_2 = Item.create(name: "Phone", description: "Phone", unit_price: 950, merchant_id: merchant_2.id)

      get "/api/v1/merchants/find?name=smi"
      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(merchant[:data][:attributes][:name]).to eq("George Smith")
    end
    xit "sad path" do
      get "/api/v1/merchants/find?name=do"
      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(merchant[:data]).to eq([])
    end
  end

end