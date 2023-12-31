class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.search_by_name(name)
    if !name.empty?
      where("name ILIKE ?", "%#{name}%").first
    end
  end
end