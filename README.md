# News API Ruby Client
A Ruby client for the [News API](https://newsapi.org/).

## Setup
1. Create an account on [News API](https://newsapi.org/docs/get-started) to get the API Key.

2. Fork and clone this repository.
```bash
$ git clone git@github.com:louisedungca/news-api-ruby-client.git
$ bundle install

```

3. Generate a new master.key and configure your credentials:
```bash
$ rails credentials:edit
```
```yaml
# tmp/some_timestamp_and_id-credentials.yml

news_api:
  api_key: your_news_api_key

# aws:
#   access_key_id: some_generated_id
#   secret_access_key: some_generated_key

# Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
secret_key_base: generated_secret_key
```

4. Start the application:
```bash
$ bin/rails db:prepare
$ bin/dev
```

## Usage

### Create an instance of the Client class
```ruby
news = NewsApi::V1::Client.new
```

### Get Everything 
Fetches news articles from over 150,000 large and small news sources and blogs related to the query parameter. See [#endpoints/everything](https://newsapi.org/docs/endpoints/everything) for the full list of request parameters that can be added.
```ruby
news.everything('Taylor Swift')
news.everything('Ruby on Rails', searchIn: 'title', sortBy: 'popularity')
```

### Get Top Keadlines
Fetches live top and breaking headlines for a country, specific category in a country, single source, or multiple sources. See [#endpoints/top-headlines](https://newsapi.org/docs/endpoints/top-headlines) for the full list of request parameters that can be added.
```ruby
news.top_headlines(country: 'us', category: 'business')
```

### Get Sources
Fetches subset of news publishers that top headlines [/top-headlines](https://newsapi.org/docs/endpoints/top-headlines) are available from. See [#endpoints/sources](https://newsapi.org/docs/endpoints/sources) for the full list of request parameters that can be added.
```ruby
news.sources(country: 'us', language: 'en')
```
