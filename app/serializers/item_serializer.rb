class ItemSerializer
  def self.format_items(items)
    item.map do |item|
      {
        id: item.id,
        name: item.name,
        description: item.description,
        unit_price: item.unit_price,
        merchant_id: item.merchant_id
      }
    end
  end
end