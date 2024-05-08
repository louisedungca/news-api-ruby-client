class NewsController < ApplicationController

  def index
    @query = params[:query].presence
    news = NewsApi::V1::Client.new
    res = news.everything(@query, sortBy: 'relevancy', language: 'en', pageSize: 10)

    if res[:status] == 200
      @articles = res[:body][:articles]
    end

  rescue Errors::ApiError => error
    flash[:error] = error.message.capitalize
    @articles = []
  end

end
