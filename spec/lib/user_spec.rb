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
end
