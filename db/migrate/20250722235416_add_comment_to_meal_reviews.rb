class AddCommentToMealReviews < ActiveRecord::Migration[8.0]
  def change
    add_column :meal_reviews, :comment, :text
  end
end
