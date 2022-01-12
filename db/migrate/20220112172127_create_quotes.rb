class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.integer :subtotal, default: 0
      t.integer :total, default: 0

      t.timestamps
    end
  end
end
