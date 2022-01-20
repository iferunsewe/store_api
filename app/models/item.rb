class Item < ApplicationRecord
  validates_presence_of :name, :code, :price
  validates_uniqueness_of :code
  validates_numericality_of :price, greater_than_or_equal_to: 0

  def formatted_price
    return "0.00€" if price.nil?
    "#{sprintf('%.2f', price/100)}€"
  end
end
