module Requests
  module JsonHelpers
    def body
      @body ||= JSON.parse(response.body)
    end
  end
end
