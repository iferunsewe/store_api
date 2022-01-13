class Quote < ApplicationRecord
  validates_presence_of :item_codes

  after_save :update_subtotal, if: :item_codes_present_and_changed?
  after_save :update_total, if: :saved_change_to_subtotal?

  def apply_discounts
    new_total = subtotal
    Discount.all.each do |discount|
      new_total = discount.apply(amount: new_total, item_codes: item_codes)
    end
    new_total
  end

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
    new_total = apply_discounts
    update(total: new_total)
  end

  def item_codes_present_and_changed?
    item_codes.present? && saved_change_to_item_codes?
  end
end
