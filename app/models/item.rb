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
    if name != ""
      where("name ILIKE ?", "%#{name}%")
    end
  end

  def self.search_by_min_price(price)
    if price != nil 
      items = where("unit_price >= #{price}", "#{price} > -1").order(unit_price: :ASC)
    end
  end

  def self.search_by_max_price(price)
    if price != nil
      items = where("unit_price <= #{price}", "#{price} > -1").order(unit_price: :DESC)
    end
  end

  def self.price_range(min, max)
    if min && max != nil
      items = where("unit_price >= #{min}", "unit_price <= #{max}", "#{min} > -1").order(unit_price: :DESC)
    end
  end
end