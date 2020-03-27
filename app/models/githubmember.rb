class Githubmember
  attr_reader :login,
              :html_url

  def initialize(attributes = Hash.new)
    @login = attributes[:login]
    @html_url = attributes[:html_url]
  end
end
