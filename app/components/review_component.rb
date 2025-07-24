class ReviewComponent < ViewComponent::Base
  def initialize(review:, removable: false, skip_review_id_tag: false)
    @review = review
    @removable = removable
    @skip_review_id_tag = skip_review_id_tag
  end

  attr_reader :review, :removable

  def author
    review.user.email.split("@").first.capitalize
  end

  def rating_class(star_number)
    base_class = "w-4 h-4"
    color = (star_number <= review.rating) ? "text-yellow-400" : "text-gray-200"

    "#{base_class} #{color}"
  end

  def review_id_tag
    "review_#{review.id}"
  end
end
