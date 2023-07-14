require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it {should have_many :items}
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items)}
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "class methods" do
    it "#search_by_name" do
      merchant_1 = create(:merchant, name: "Bill Smith")
      merchant_2 = create(:merchant, name: "William")
      expect(Merchant.search_by_name("Bill")). to eq(merchant_1)
    end
  end
end