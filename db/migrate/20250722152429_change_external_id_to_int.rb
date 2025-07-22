class ChangeExternalIdToInt < ActiveRecord::Migration[8.0]
  def change
    change_column :meals, :external_id, :integer, using: "external_id::integer"
    change_column :categories, :external_id, :integer, using: "external_id::integer"
  end
end
