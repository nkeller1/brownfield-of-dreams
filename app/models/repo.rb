class Repo
  attr_reader :name,
              :html_url

  def initialize(attributes = Hash.new)
    @name = attributes[:name]
    @html_url = attributes[:html_url]
  end
end
