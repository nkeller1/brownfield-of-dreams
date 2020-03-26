class GithubSearch
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def repos
    response = Faraday.get("https://api.github.com/user/repos?access_token=#{@token}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
