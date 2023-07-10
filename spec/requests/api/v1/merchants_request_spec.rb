require "rails_helper"

describe "all merchants" do
  it "can return all merchants" do
    create_list(:merchant, 8)

    get "/api/v1/merchants"
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants.count).to eq(8)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(Integer)

      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to be_an(String)
    end

  end
end