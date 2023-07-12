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
    items = create_list(:item, 10, merchant_id: id)

    get "/api/v1/merchants/#{id}/items"

    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(merchant[:data]).to have_key(:relationships)
    expect(merchant[:data][:relationships][:items][:data][0][:type]).to eq("item")
  end
end