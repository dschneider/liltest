require "typhoeus"

module Liltest
  class Request
    def initialize(method, endpoint, body, headers)
      @response = Typhoeus::Request.new(
        endpoint,
        method:        method,
        body:          body,
        params:        nil,
        headers:       headers
      ).run
    end

    def body
      @response.body
    end
  end
end
