class CreateDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_table :discounts do |t|
      t.integer :discount_type
      t.string :code
      t.integer :min_quantity
      t.integer :quote_id
      t.integer :discount_percentage, default: 0

      t.timestamps
    end
  end
end
