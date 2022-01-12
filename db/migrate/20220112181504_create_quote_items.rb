class CreateQuoteItems < ActiveRecord::Migration[6.0]
  def change
    create_table :quote_items do |t|
      t.integer :item_id
      t.integer :quote_id

      t.timestamps
    end
  end
end
