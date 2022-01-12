class Quote < ApplicationRecord
  has_many :quote_items
  has_many :items, through: :quote_items
end
