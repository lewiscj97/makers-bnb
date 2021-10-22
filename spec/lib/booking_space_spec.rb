describe '#booingSpace' do
  describe '#get_by_id' do
    it 'can join bookings and spaces table and return values' do
      owner = DatabaseConnection.query("INSERT INTO users(id, username, email, password) VALUES(1, 'Foo', 'foo@bar.com', 'password');")
      customer = DatabaseConnection.query("INSERT INTO users(username, email, password) VALUES('Bar', 'bar@bar.com', 'password');")
      DatabaseConnection.query("INSERT INTO spaces(id, space_name, description, rate, user_id) VALUES(1, 'Space', 'A lovely home', 50 , 1);")
      DatabaseConnection.query("INSERT INTO bookings(space_id, user_id, date_from, date_to, confirmed) VALUES(1, 1, '2021-10-20', '2021-10-25', '0');")

      response = DatabaseConnection.query(
        'SELECT bookings.id, date_from, date_to, confirmed, space_name, description, rate, bookings.user_id FROM users
        JOIN spaces ON users.id=spaces.user_id
        JOIN bookings ON spaces.user_id = users.id
        WHERE users.id = 1'
      )
      result = response.first

      expect(result['date_from']).to eq '2021-10-20'
      expect(result['date_to']).to eq '2021-10-25'
      expect(result['confirmed']).to eq '0'
      expect(result['space_name']).to eq 'Space'
      expect(result['description']).to eq 'A lovely home'
      expect(result['rate']).to eq '50'
      expect(result['user_id']).to eq '1'
    end
  end
end