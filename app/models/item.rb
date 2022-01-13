class Item < ApplicationRecord
  validates_presence_of :name, :code, :price
  validates_uniqueness_of :code

  def formatted_price
    "#{sprintf('%.2f', price/100)}€"
  end
end
