require "uri"
require "net/http"

class AvaApi
    def self.fetch_records(symbol)
        url = URI("https://alpha-vantage.p.rapidapi.com/query?function=TIME_SERIES_DAILY&symbol=#{symbol}")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-key"] = ENV["API_KEY"]
        request["x-rapidapi-host"] = "alpha-vantage.p.rapidapi.com"

        response = http.request(request)
        JSON.parse(response.body)
    end
end
