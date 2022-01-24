class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.decimal :subtotal
      t.decimal :total
      t.references :user, index: true, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
