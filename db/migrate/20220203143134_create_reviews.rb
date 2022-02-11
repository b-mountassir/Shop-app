class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :body
      t.integer :rating
      t.belongs_to :product, null: false, foreign_key: true
      t.belongs_to :reviewer, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
