module GraphQL
  module ResponseParser
    def gql_response
      return @json_response if response.body.object_id == @response_id

      @response_id = response.body.object_id
      @json_response = JSON.parse(response.body)
    end
  end
end
