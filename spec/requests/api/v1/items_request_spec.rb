require "rails_helper"

describe "all items" do
  it "can return all items" do
    create_list(:item, 12)

    get "/api/v1/items"
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items.count).to eq(12)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(Integer)

      expect(item).to have_key(:name)
      expect(item[:name]).to be_an(String)

      expect(item).to have_key(:description)
      expect(item[:description]).to be_an(String)

      expect(item).to have_key(:unit_price)
      expect(item[:unit_price]).to be_an(Float)

      # expect(item).to have_foreign_key(merchant_id)
      # expect(item[:merchant_id]).to be_an(Integer)
    end
  end
end