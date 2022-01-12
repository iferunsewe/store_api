class Quote < ApplicationRecord
  validates_presence_of :item_codes

  after_save :update_subtotal, if: :item_codes_present_and_changed?
  after_save :update_total, if: :saved_change_to_subtotal?

  private

  def update_subtotal
    subtotal = 0
    item_codes.each do |item_code|
      item = Item.find_by(code: item_code)
      subtotal += item.price
    end
    update(subtotal: subtotal)
  end

  def update_total
    update(total: subtotal)
  end

  def item_codes_present_and_changed?
    item_codes.present? && saved_change_to_item_codes?
  end
end
