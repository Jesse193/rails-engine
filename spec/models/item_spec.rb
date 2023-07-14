require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end
  before(:each) do
    @customer = Customer.create!(first_name: "Bob", last_name: "Smith" )
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = Item.create(name: "Computer", description: "Computer for special tasks", unit_price: 1000, merchant_id: @merchant_1.id)
    @item_2 = Item.create(name: "Phone", description: "Phone", unit_price: 950, merchant_id: @merchant_2.id)
    @item_3 = Item.create(name: "Computer 2.0", description: "Computer for even more special tasks", unit_price: 1500, merchant_id: @merchant_1.id)
    @invoice = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant_1.id, status: "Pending")
    @transaction = Transaction.create!(invoice_id: @invoice.id, credit_card_number: 12345678, credit_card_expiration_date: 1/24, result: "pending")
    @invoice_item = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice.id)
  end

  describe "class methods" do
    it "#search_by_name" do
      expect(Item.search_by_name("Computer")).to eq([@item_1, @item_3])
    end
    it "#search_by_min_price" do
      expect(Item.search_by_min_price(1500)).to eq([@item_3])
    end
    it "#search_by_max_price" do
      expect(Item.search_by_max_price(950)).to eq([@item_2])
    end
  end

  describe "instance methods" do
    xit "delete_invoices" do
      delete "/api/v1/items/#{@item_1.id}"
      expect(@invoice).to eq(nil)
    end
  end
end