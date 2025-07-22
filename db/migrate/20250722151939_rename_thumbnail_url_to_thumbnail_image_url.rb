class RenameThumbnailUrlToThumbnailImageUrl < ActiveRecord::Migration[8.0]
  def change
    rename_column :meals, :thumbnail_url, :thumbnail_image_url
    rename_column :categories, :thumbnail_url, :thumbnail_image_url
  end
end
