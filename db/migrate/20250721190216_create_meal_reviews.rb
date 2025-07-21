class CreateMealReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :meal_reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :meal, null: false, foreign_key: true
      t.integer :rating

      t.timestamps
    end
  end
end
