class CreateSwipes < ActiveRecord::Migration[7.0]
  def change
    create_table :swipes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :meal, null: false, foreign_key: true
      t.integer :preference, null: false, default: 0
      t.timestamps
    end
    add_index :swipes, [:user_id, :meal_id], unique: true
  end
end
