module Areas
  class Getter < ApplicationService
    PATH = "list.php?a=list"
    CACHE_KEY = "areas_list"

    def initialize
      @client = TheMealDB::Client.new
    end

    def call
      Rails.cache.fetch(CACHE_KEY, expires_in: CACHE_EXPIRY) do
        areas.map { |area| area["strArea"] }
      end
    end

    private

    attr_reader :client

    def areas
      response = client.get(PATH)
      response["meals"] || []
    end
  end
end
