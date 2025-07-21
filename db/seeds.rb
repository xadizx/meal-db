if Rails.env.development?
  # Import real categories from the MealDB API
  Categories::Importer.call

  # Call the Areas::Getter service so it will cache the areas
  Areas::Getter.call
end
