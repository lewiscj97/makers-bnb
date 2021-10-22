require 'booking_space'

describe BookingSpace do
  describe '#get_by_id' do
    it 'can join bookings and spaces table and return values' do
      owner = DatabaseConnection.query("INSERT INTO users(id, username, email, password) VALUES(1, 'Foo', 'foo@bar.com', 'password');")
      customer = DatabaseConnection.query("INSERT INTO users(id, username, email, password) VALUES(2, 'Bar', 'bar@bar.com', 'password');")
      DatabaseConnection.query("INSERT INTO spaces(id, space_name, description, rate, user_id) VALUES(1, 'Space', 'A lovely home', 50 , 1);")
      DatabaseConnection.query("INSERT INTO bookings(space_id, user_id, date_from, date_to, confirmed) VALUES(1, 2, '2021-10-20', '2021-10-25', '0');")

      response = DatabaseConnection.query(
        'SELECT bookings.id, date_from, date_to, confirmed, space_name, description, rate, bookings.user_id FROM users
        JOIN spaces ON users.id=spaces.user_id
        JOIN bookings ON spaces.user_id = users.id
        WHERE users.id = 1'
      )

      result = response.first
      booking = BookingSpace.get_by_id(1).first

      expect(booking.date_from).to eq result['date_from']
      expect(booking.date_to).to eq result['date_to']
      expect(booking.confirmed).to eq result['confirmed']
      expect(booking.space_name).to eq result['space_name']
      expect(booking.description).to eq result['description']
      expect(booking.rate).to eq result['rate']
      expect(booking.customer_id).to eq result['user_id']
    end
  end
end
