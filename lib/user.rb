class User
  def initialize(id, username, email, password)
    @id = id
    @username = username
    @email = email
    @password = password
  end

  attr_reader :id, :username, :email, :password
end
