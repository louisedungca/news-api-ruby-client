class NewsController < ApplicationController
  def index
    @query = params[:query].presence
    return @articles = [] unless @query.present?

    news = NewsApi::V1::Client.new
    all_news = news.everything(@query, sortBy: 'relevancy', language: 'en', pageSize: 20)
    top_news = news.top_headlines(country: 'ph', pageSize: 15)

    if all_news[:status] == 200
      @articles = all_news[:body][:articles]
    else
      flash[:error] = "Failed to fetch news articles. #{all_news[:body]['message'.capitalize]}"
      @articles = []
    end

    if top_news[:status] == 200
      @top_articles = top_news[:body][:articles]
    else
      flash[:error] = "Failed to fetch news articles. #{top_news[:body]['message'.capitalize]}"
      @top_articles = []
    end

  rescue Errors::ApiError => error
    flash[:error] = error.message.capitalize
    @articles = []
  end
end
