module Base
  class Http
    DEFAULT_OPTIONS = { headers: {} }.freeze

    def initialize(options = {})
      headers, params = parse_options(options)

      @http = Faraday.new(url: options[:base_url], headers: headers, params: params) do |faraday|
        faraday.response :logger, ::Logger.new($stdout), bodies: true
      end
    end

    def get(url)
      response = @http.get(url)
  
      handle_response(response)
    end

    private

    def parse_options(options)
      options = DEFAULT_OPTIONS.merge(options)

      base_headers = {
        accept: "application/json",
        user_agent: "fintera-account",
      }.merge(options[:headers])

      headers = base_headers.merge({ content_type: "application/json" })
      params = options[:params] || {}

      [headers, params]
    end

    def handle_response(response)
      parsed_body = parse_body(response.body)

      return { "error" => parsed_body } if (400..599).include?(response.status)

      parsed_body
    end

    def parse_body(body)
      JSON.parse(body)
    rescue
      body
    end
  end
end
