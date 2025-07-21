class CreateFavouriteMeals < ActiveRecord::Migration[8.0]
  def change
    create_table :favourite_meals do |t|
      t.references :user, null: false, foreign_key: true
      t.references :meal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
