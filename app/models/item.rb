class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  before_destroy :delete_invoice, prepend: true

  def delete_invoice
    self.invoice_items.each do |invoice_item|
      if invoice_item.invoice.items.count == 1
        invoice_item.invoice.destroy!
        invoice_item.destroy!
      end
    end
  end

  def self.search_by_name(name)
    where("name ILIKE ?", "%#{name}%")
  end

  def self.search_by_min_price(price)
    where("unit_price >= #{price}")
  end

  def self.search_by_max_price(price)
    where("unit_price <= #{price}")
  end
end