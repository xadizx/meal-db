class CategoryImporter < ApplicationService
  PATH = "categories.php"

  def call
    ActiveRecord::Base.transaction do
      api_categories.each { |api_category| find_or_create_category!(api_category) }
    end
  end

  private

  def client
    @client ||= TheMealDB::Client.new
  end

  def api_categories
    response = client.get(PATH)
    response["categories"] || []
  end

  def find_or_create_category!(api_category)
    Category.find_or_initialize_by(external_id: api_category["idCategory"]).tap do |category|
      category.name = api_category["strCategory"]
      category.thumbnail_url = api_category["strCategoryThumb"]
      category.description = api_category["strCategoryDescription"]
      category.save!
    end
  end
end
