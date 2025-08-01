class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :external_id
      t.string :name
      t.string :thumbnail_url
      t.text :description

      t.timestamps
    end
  end
end
