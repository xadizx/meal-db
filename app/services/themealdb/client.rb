module TheMealDB
  class Client
    BASE_URL = "https://www.themealdb.com/api/json/v1"

    def initialize
      @key = ENV.fetch("MEALDB_API_KEY")
    end

    def get(path, params = {})
      url = prepare_url(path)
      response = Faraday.get(url, params)

      raise "Failed to fetch #{url}: #{response.status}" unless response.success?

      JSON.parse(response.body)
    end

    private

    attr_reader :key

    def prepare_url(path)
      "#{BASE_URL}/#{key}/#{path}"
    end
  end
end
