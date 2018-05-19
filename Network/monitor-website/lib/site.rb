class Site

  def initialize url:
    @url = url
  end

  def call
    url = URI.parse(@url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = url.scheme == 'https'
    begin
      response = http.get(@url)
      case response
      when Net::HTTPSuccess then
        response
      when Net::HTTPRedirection then
        location = response['location']
      end
      return {code: response.code, url: @url}
    rescue *HTTP_ERRORS => error
      return {code: "Wrong url!", url: @url}
    end
  end
end
