class CreateSellerOrder < ActiveRecord::Migration[6.1]
  def change
    create_table :seller_orders do |t|
      t.references :order, index: true, null: false, foreign_key: true
      t.decimal :total
      t.decimal :subtotal
      t.references :buyer, index: true, null: false, foreign_key: { to_table: :users }
      t.references :seller, index: true, null: false, foreign_key: { to_table: :users }


      t.timestamps
    end
  end
end
