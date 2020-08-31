class BlogsController < ApplicationController
  Query = GqlTest::Client.parse <<-GRAPHQL
  query ($user: String!) {
    repositoryOwner(login: $user) {
        repositories(last:5){
            nodes {
                name
            }
        }
    }
}
    GRAPHQL
  def index
    username = "hinokage08"
    @works = result(user: username).data.repository_owner.repositories.nodes
  end

  private
  def result(variables = {})
    response = GqlTest::Client.query(Query, variables: variables)
  end
end
