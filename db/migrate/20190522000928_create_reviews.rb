class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :wine_id
      t.text :comments
      t.integer :heaviness
      t.integer :fruitiness
      t.integer :acidity
      t.integer :rating

      t.timestamps
    end
  end
end
