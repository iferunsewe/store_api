class Item < ApplicationRecord
  validates_presence_of :name, :code, :price
  validates_uniqueness_of :code
end
