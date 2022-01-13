class Discount < ApplicationRecord
  enum discount_type: %i[bundle percentage]

  validates_presence_of :discount_type, :code, :min_quantity

  def apply(amount:, item_codes:)
    code_count = item_codes.tally[code]
    
    send("apply_#{discount_type}", amount: amount, code_count: code_count)
  end

  private

  def apply_bundle(amount:, code_count:)
    return amount if code_count < min_quantity
    item = Item.find_by(code: code)
    return amount if item.nil?

    discounted_amount = amount
    deduction = item.price
    discounted_amount -= deduction
  end


  def apply_percentage(amount:, code_count:)
    return amount if discount_percentage.nil? || code_count < min_quantity
    item = Item.find_by(code: code)
    return amount if item.nil?

    discounted_amount = amount
    deduction = (code_count * item.price) * (discount_percentage.to_f/100.to_f)
    discounted_amount -= deduction
    discounted_amount.to_i
  end
end
