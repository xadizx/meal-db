module TheMealDB
  class Client
    BASE_URL = "https://www.themealdb.com/api/json/v1"
    DEFAULT_CACHE_EXPIRY = 24.hour

    def initialize
      @key = ENV.fetch("MEALDB_API_KEY")
    end

    def get(path, params = {}, cache_key: nil, expires_in: DEFAULT_CACHE_EXPIRY)
      if cache_key.present?
        Rails.cache.fetch(cache_key, expires_in: expires_in) do
          get_without_cache(path, params)
        end
      else
        get_without_cache(path, params)
      end
    end

    private

    attr_reader :key

    def get_without_cache(path, params)
      url = prepare_url(path)
      response = Faraday.get(url, params)

      raise "Failed to fetch #{url}: #{response.status}" unless response.success?

      JSON.parse(response.body)
    end

    def prepare_url(path)
      "#{BASE_URL}/#{key}/#{path}"
    end
  end
end
