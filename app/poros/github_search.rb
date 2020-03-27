class GithubSearch
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def conn(path)
    Faraday.get("https://api.github.com/user/#{path}?access_token=#{@token}")
  end

  def repos
    response = conn("repos")
    JSON.parse(response.body, symbolize_names: true)
  end

  def followers
    response = conn("followers")
    JSON.parse(response.body, symbolize_names: true)
  end

  def following
    response = conn("following")
    JSON.parse(response.body, symbolize_names: true)
  end
end
