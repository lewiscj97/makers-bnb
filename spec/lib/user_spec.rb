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

      DatabaseConnection.query("INSERT INTO users(username, email, password) VALUES('Foo', 'foo@bar.com, 'password');")
      result = User.sign_in('foo@bar.com', 'password')
      
      expect(result).to eq true   
    end

    it 'returns false when credentials do not match'
    DatabaseConnection.query("INSERT INTO users(username, email, password) VALUES('Foo', 'foo@bar.com, 'password');")

    result = User.sign_in('foo@bar.com', 'wrongpassword')
    
    expect(result).to eq false

  end

end
