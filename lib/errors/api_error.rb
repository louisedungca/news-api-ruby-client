class Errors::ApiError < StandardError
  attr_reader :faraday_error_class

  def initialize(message: nil, faraday_error_class: nil)
    super(message)
    @faraday_error_class = faraday_error_class
  end
end
