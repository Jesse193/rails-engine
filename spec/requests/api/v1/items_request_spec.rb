require "rails_helper"

describe "items api" do
  it "can return all items" do
    create_list(:item, 12)

    get "/api/v1/items"
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(12)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:attributes][:id].to_i).to be_an(Integer)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

    end
  end

  it "can find item by id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"
    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id].to_i).to be_an(Integer)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_an(Float)
  end

  it "can create new item" do
    merchant = create(:merchant).id
    item_params = ({name: "Computer", description: "Computer", unit_price: 1000, merchant_id: merchant})
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    item = Item.last

    expect(response).to be_successful

    expect(item.name).to eq(item[:name])
    expect(item.description).to eq(item[:description])
    expect(item.unit_price).to eq(item[:unit_price])
    expect(item.merchant_id).to eq(item[:merchant_id])
  end
end