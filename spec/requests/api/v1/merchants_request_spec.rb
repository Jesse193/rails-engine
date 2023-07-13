require "rails_helper"

describe "merchants api" do
  it "can return all merchants" do
    create_list(:merchant, 8)

    get "/api/v1/merchants"
    
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    
    expect(merchants[:data].count).to eq(8)
    
    merchants[:data].each do |merchant|

      expect(merchant).to have_key(:id)
      expect(merchant[:id].to_i).to be_an(Integer)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end

  it "can return a merchant" do
    id = create(:merchant).id
    
    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id].to_i).to be_an(Integer)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_an(String)
  end

  it "can return all merchant's items" do
    id = create(:merchant).id
    merchant_2 = create(:merchant)
    all_items = create_list(:item, 10, merchant_id: id)
    item_2 = create(:item, merchant_id: merchant_2.id)

    get "/api/v1/merchants/#{id}/items"

    items = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to eq(item[:id])
      # expect(item).to have_key(:relationships)
      # expect(item[:relationships][:merchant][:data][:type]).to eq("merchant")
      # expect(item[:relationships][:merchant][:data][:id]).to eq(id.to_s)
    end
  end
end