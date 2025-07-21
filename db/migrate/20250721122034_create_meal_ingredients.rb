class CreateMealIngredients < ActiveRecord::Migration[8.0]
  def change
    create_table :meal_ingredients do |t|
      t.references :meal, null: false, foreign_key: true
      t.string :name
      t.string :measurement

      t.timestamps
    end
  end
end
