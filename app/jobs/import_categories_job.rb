class ImportCategoriesJob < ApplicationJob
  queue_as :default

  def perform
    Categories::Importer.call
  end
end
