class MealDecorator < Draper::Decorator
  delegate_all

  def to_thumbnail
    MealThumbnail.new(
      external_id: object.external_id,
      name: object.name,
      thumbnail_image_url: object.thumbnail_image_url,
      category_name: object.category.name
    )
  end
end
