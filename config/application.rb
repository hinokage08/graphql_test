require_relative 'boot'

require 'rails/all'
require "graphql/client"
require "graphql/client/http"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GqlTest
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
  AUTH_HEADER = "Bearer [your access token]"
  HTTP = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do 
    def headers(context)
      { "Authorization": AUTH_HEADER }
    end
  end
  # 上記を使って API サーバーから GraphQL Schema 情報を取得
  Schema = GraphQL::Client.load_schema(HTTP)
  # 上記を使ってクライアントを作成
  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
end
