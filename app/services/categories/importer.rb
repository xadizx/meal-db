module Categories
  class Importer < ApplicationService
    PATH = "categories.php"

    def initialize
      @client = TheMealDB::Client.new
    end

    def call
      ActiveRecord::Base.transaction do
        api_categories.each { |api_category| update_or_create_category!(api_category) }
      end
    end

    private

    attr_reader :client

    def api_categories
      response = client.get(PATH)
      response["categories"] || []
    end

    def update_or_create_category!(api_category)
      Category.find_or_initialize_by(external_id: api_category["idCategory"]).tap do |category|
        category.name = api_category["strCategory"]
        category.thumbnail_image_url = api_category["strCategoryThumb"]
        category.description = api_category["strCategoryDescription"]
        category.save!
      end
    end
  end
end
