module Areas
  class Getter < ApplicationService
    def initialize
      @client = TheMealDB::Client.new
    end

    def call
      areas.map { |area| area["strArea"] }
    end

    private

    attr_reader :client

    def areas
      response = client.get("list.php?a=list", cache_key: "areas_list")
      response["meals"] || []
    end
  end
end
