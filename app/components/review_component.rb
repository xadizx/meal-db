class ReviewComponent < ViewComponent::Base
  def initialize(author:, rating:, comment:, review_id:, removable: false)
    @author = author
    @rating = rating
    @comment = comment
    @review_id = review_id
    @removable = removable
  end
end
