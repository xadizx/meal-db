class ReviewComponent < ViewComponent::Base
  def initialize(user:, rating:, comment:, removable: false)
    @user = user
    @rating = rating
    @comment = comment
    @removable = removable
  end
end
