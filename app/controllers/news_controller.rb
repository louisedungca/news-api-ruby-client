class NewsController < ApplicationController

  def index
    news = NewsApi::V1::Client.new
    res = news.everything('Ruby on Rails')

    if res[:status] == 200
      @articles = res[:body][:articles]
    else
      flash[:error] = "Failed to fetch news articles: #{res[:body]['message']}"
      @articles = []
    end

  rescue Errors::ApiError => error
    flash[:error] = error.message.capitalize
    @articles = []
  end
end
