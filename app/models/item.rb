class Item < ApplicationRecord
  validates_presence_of :name, :code, :price
  validates_uniqueness_of :code

  has_many :quote_items
  has_many :quotes, through: :quote_items
end
