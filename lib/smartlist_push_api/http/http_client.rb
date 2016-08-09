module SmartlistPushApi
  module Http
    class HttpClient

      def initialize()
        @default_headers = {
            'x-access-token' => SmartlistPushApi.access_token,
            'Accept' => 'application/json'
        }
      end

      def post_request(url, data)
        HTTParty.post("#{SmartlistPushApi.base_uri}#{url}", {body: data, headers: @default_headers})
      end

      def patch_request(url, data)
        HTTParty.patch("#{SmartlistPushApi.base_uri}#{url}", {body: data, headers: @default_headers})
      end

      def get_request(url)
        HTTParty.get("#{SmartlistPushApi.base_uri}#{url}", {headers: @default_headers})
      end

      def delete_request(url)
        HTTParty.delete("#{SmartlistPushApi.base_uri}#{url}", {headers: @default_headers})
      end

    end
  end
end