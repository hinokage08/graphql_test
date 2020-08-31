class BlogsController < ApplicationController
  Query = GqlTest::Client.parse <<-GRAPHQL
  query {
    viewer {
      repositories(last:5) {
        edges {
          node {
            name
          }
        }
      }
    }
  }
    GRAPHQL
  def index
    @works = result.data.viewer.repositories.edges
  end

  private
  def result
    response = GqlTest::Client.query(Query)
  end
end
