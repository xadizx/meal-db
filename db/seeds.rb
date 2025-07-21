if Rails.env.development?
  # Import real categories from the MealDB API
  CategoryImporter.call
end
