class AreaGetter < ApplicationService
  PATH = "list.php?a=list"
  CACHE_KEY = "areas_list"
  CACHE_EXPIRY = 24.hours

  def call
    Rails.cache.fetch(CACHE_KEY, expires_in: CACHE_EXPIRY) do
      areas.map { |area| area["strArea"] }
    end
  end

  private

  def client
    @client ||= TheMealDB::Client.new
  end

  def areas
    response = client.get(PATH)
    response["meals"] || []
  end
end
