# frozen_string_literal: true

require 'graphql/client'
require 'http_client'

# Module ShopifyPartnerApi
module ShopifyPartnerApi
  class << self
    delegate :parse, :query, to: :client

    def client
      initialize_client_cache
      cached_client = @_client_cache

      if !cached_client.nil?
        cached_client
      else
        initialize_client
        @_client_cache
      end
    end

    def initialize_client
      initialize_client_cache
      http = ShopifyPartnerApi::HTTPClient.new

      # So the schema is not requested every time the client is initialized we store it on disk.
      # If the schema changes, run GraphQL::Client.dump_schema(http, "config/partner-api-schema.json")
      unless File.exist?('config/partner-api-schema.json')
        GraphQL::Client.dump_schema(http,
                                    'config/partner-api-schema.json')
      end
      schema = GraphQL::Client.load_schema('config/partner-api-schema.json')
      client = GraphQL::Client.new(schema: schema, execute: http)

      @_client_cache = client
    end

    private

    def initialize_client_cache
      @_client_cache ||= nil # rubocop:disable Naming/MemoizedInstanceVariableName
    end
  end
end
