class Friend
  attr_reader :name, :id, :token

  def initialize(name, id, token)
    @name = name
    @id = id
    @token = token
  end

  def picture_url
    token.get_picture(id)
  end

end
