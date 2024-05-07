# frozen_string_literal: true

require 'faraday'

class NewsApi::V1::Client
  API_BASE_URL = 'https://newsapi.org/v2'
  API_KEY = Rails.application.credentials.news_api.api_key

  private

  def client
    @client ||= begin
      options = {
        request: {
          # modify timeout behavior in sec (faraday default = 60sec)
          open_timeout: 10, # if connection is not established within said time, req will timeout and raise an error
          read_timeout: 10 # if connection is not read within said time, req will timeout and raise an error
        }
      }

      # configure http client instance using faraday middlewares
      # ref: https://lostisland.github.io/faraday/#/middleware/index?id=available-middleware
      Faraday.new(url: API_BASE_URL, **options) do |conn|
        conn.request :authorization, 'Bearer', API_KEY
        conn.request :json
        conn.response :json, parser_options: { symbolize_names: true } # ref: https://github.com/lostisland/faraday_middleware/wiki/Parsing-responses
        conn.response :raise_error # raise Faraday::Error on status code 4xx or 5xx
        conn.response :logger, Rails.logger, headers: true, bodies: true, log_level: :debug # ref: https://www.rubydoc.info/github/lostisland/faraday/Faraday/Logging/Formatter
      end
    end
  end

end
