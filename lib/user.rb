# frozen_string_literal: true

class User
  attr_reader :id, :username, :email, :password

  def initialize(id, username, email, password)
    @id = id
    @username = username
    @email = email
    @password = password
  end

  def self.sign_in(email, password)
    response = DatabaseConnection.query('SELECT password FROM users WHERE email LIKE $1', [email])
    result = response.first
    return false if result.nil?

    result_password = result['password']
    result_password == password
  end

  def self.create(username, email, password)
    result = DatabaseConnection.query(
      'INSERT INTO users (username, email, password) VALUES($1, $2, $3) RETURNING id, username, email, password;', [username,
                                                                                                                    email, password]
    )
    User.new(result[0]['id'], result[0]['username'], result[0]['email'], result[0]['password'])
  end

  def self.find(id)
    result = DatabaseConnection.query("SELECT * FROM users WHERE id = $1", [id])
    User.new(result[0]['id'], result[0]['username'], result[0]['email'], 'protected')
  end
end
