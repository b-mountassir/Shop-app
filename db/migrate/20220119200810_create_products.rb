class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price, default: 0.0
      t.text :description
      t.integer :stock, default: 0

      t.timestamps
    end
  end
end
