class AddShownAndPublishedToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :on_sale, :boolean, default: false, null: false
    add_column :products, :published, :boolean, default: false, null: false
  end
end
