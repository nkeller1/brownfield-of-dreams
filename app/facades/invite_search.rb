class InviteSearch
  def initialize(handle, token)
    @handle = handle
    @token = token
  end

  def response
    Faraday.get("https://api.github.com/users/#{@handle}?access_token=#{@token}")
  end

  def invitee_email
    JSON.parse(response.body, symbolize_names: true)[:email]
  end

  def invitee_name
    JSON.parse(response.body, symbolize_names: true)[:name]
  end
end
