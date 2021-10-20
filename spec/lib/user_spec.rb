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
end
