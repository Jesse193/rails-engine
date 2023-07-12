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

  it "can create new item then delete" do
    merchant = create(:merchant).id
    created_item = create(:item)

    item_params = ({name: "Computer", description: "Computer", unit_price: 1000, merchant_id: merchant})
    headers = {"CONTENT_TYPE" => "application/json"}

    expect(Item.count).to eq(1)
    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    item = JSON.parse(response.body, symbolize_names: true)

    expect(Item.count).to eq(1)

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id].to_i).to be_an(Integer)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_an(Float)

    expect(item[:data][:attributes][:name]).to eq("Computer")
    expect(item[:data][:attributes][:description]).to eq("Computer")
    expect(item[:data][:attributes][:unit_price]).to eq(1000)

  end

  it "can update an item" do
    merchant = create(:merchant).id
    item = Item.create(name: "Computer", description: "Computer", unit_price: 1000, merchant_id: merchant)
    old_description = Item.last.description
    item_params = ({description: "A computer to help with tasks"})
    headers = {"CONTENT_TYPE" => "application/json"}
  
    patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: item_params)

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(item[:data][0]).to have_key(:id)
    expect(item[:data][0][:id].to_i).to be_an(Integer)

    expect(item[:data][0][:attributes]).to have_key(:name)
    expect(item[:data][0][:attributes][:name]).to be_an(String)

    expect(item[:data][0][:attributes]).to have_key(:description)
    expect(item[:data][0][:attributes][:description]).to be_an(String)

    expect(item[:data][0][:attributes]).to have_key(:unit_price)
    expect(item[:data][0][:attributes][:unit_price]).to be_an(Float)

    expect(item[:data][0][:attributes][:name]).to eq("Computer")
    expect(item[:data][0][:attributes][:description]).to_not eq("Computer")
    expect(item[:data][0][:attributes][:unit_price]).to eq(1000)


  end

  it "can destroy item and destroys invoice if there are no items" do
    customer = Customer.create!(first_name: "Bob", last_name: "Smith" )
    merchant = create(:merchant)
    item = Item.create!(name: "Computer", description: "Computer", unit_price: 1000, merchant_id: merchant.id)
    invoice = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "Pending")
    transaction = Transaction.create!(invoice_id: invoice.id, credit_card_number: 12345678, credit_card_expiration_date: 1/24, result: "pending")
    invoice_item = InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id)

    item_params = ({name: "Computer", description: "Computer", unit_price: 1000, merchant_id: merchant})

    expect(item.invoices).to eq([invoice])

    delete "/api/v1/items/#{item.id}"

    expect(Invoice.all).to eq([])
    expect(Item.all).to eq([])

  end




end