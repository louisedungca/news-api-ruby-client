# frozen_string_literal: true

require 'faraday'

class NewsApi::V1::Client
  API_BASE_URL = 'https://newsapi.org/v2'
  API_KEY = Rails.application.credentials.news_api.api_key

  # endpoint method
  def everything(q = '', **params)
    request(
      http_method: :get,
      endpoint: 'everything',
      params: { q: q, **params }
    )
  end

  # add more endpoint methods as needed

  private

  def client
    @client ||= begin
      options = {
        request: {
          open_timeout: 10,
          read_timeout: 10
        }
      }
      Faraday.new(url: API_BASE_URL, **options) do |conn|
        conn.request :authorization, 'Bearer', API_KEY
        conn.request :json
        conn.response :json, parser_options: { symbolize_names: true }
        conn.response :raise_error
        conn.response :logger, Rails.logger, headers: true, bodies: true, log_level: :debug
      end
    end
  end

  def request(http_method:, endpoint:, params: {}) # add 'body: {}' if you'll have a post/patch http method (check endpoint method requirements)
    response = client.public_send(http_method, endpoint, params) # add 'body' if you'll have a post/patch http method
    {
      status: response.status,
      body: response.body
    }
  rescue Faraday::Error => error
    puts error.inspect
  end

end
