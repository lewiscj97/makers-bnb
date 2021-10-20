require 'user'

describe User do
  describe "#initialize" do
    it "can be passed an id, username, email and password" do
      user = User.new(1, 'foo', 'foo@bar.com', 'password')
      
      expect(user.id).to eq 1
      expect(user.username).to eq 'foo'
      expect(user.email).to eq 'foo@bar.com'
      expect(user.password).to eq 'password'
    end
  end

  describe '#sign in' do
    it 'returns true when credentials match' do
      DatabaseConnection.query("INSERT INTO users(username, email, password) VALUES('Foo', 'foo@bar.com', 'password');")
      result = User.sign_in('foo@bar.com', 'password')
      
      expect(result).to eq true   
    end

    it 'returns false when credentials do not match' do
      DatabaseConnection.query("INSERT INTO users(username, email, password) VALUES('Foo', 'foo@bar.com', 'password');")
      result = User.sign_in('foo@bar.com', 'wrongpassword')
    
      expect(result).to eq false
    end

    it 'returns false when the email is not in the database' do
      result = User.sign_in('foo@bar.com', 'wrongpassword')
      expect(result).to eq false
    end
  end

  describe "#create" do
    it "creates a new user" do
      user = User.create('Brian', 'test@email.com', 'password123')
      persisted_data = DatabaseConnection.query("SELECT * FROM users WHERE id = $1;", [user.id])

      expect(user.id).to eq persisted_data.first['id']
      expect(user.username).to eq 'Brian'
      expect(user.email).to eq 'test@email.com'
      expect(user.password).to eq 'password123'
    end
  end

  describe "#find" do
    it 'returns a user object when passed the user id' do
      DatabaseConnection.query("INSERT INTO users(username, email, password) VALUES('Foo', 'foo@bar.com', 'password');")
      response = DatabaseConnection.query("SELECT * FROM users WHERE email LIKE 'foo@bar.com';")
      id = response.first['id']
      user = User.find(id)
      
      expect(user.id).to eq id
      expect(user.username).to eq 'Foo'
      expect(user.email).to eq 'foo@bar.com'
      expect(user.password).to eq 'protected'
    end
  end
end
