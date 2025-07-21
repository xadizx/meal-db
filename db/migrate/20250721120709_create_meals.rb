class CreateMeals < ActiveRecord::Migration[8.0]
  def change
    create_table :meals do |t|
      t.string :external_id
      t.string :name
      t.string :thumbnail_url
      t.string :tags
      t.text :instructions
      t.string :area
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
