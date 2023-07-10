require "rails_helper"

describe "all merchants" do
  it "can return all merchants" do
    create_list(:merchant, 8)

    get '/api/v1/merchants'
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants.count).to eq(8)

  end
end