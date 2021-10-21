require 'booking'

describe Booking do
  describe '#initialize' do
    it 'can be passed the booking details' do
      booking = Booking.new(id: 1, space_id: 1, user_id: 1, date_from: '2021-10-18', date_to: '2021-10-23', confirmed: 0)
      expect(booking.id).to eq 1
      expect(booking.space_id).to eq 1
      expect(booking.user_id).to eq 1
      expect(booking.date_from).to eq '2021-10-18'
      expect(booking.date_to).to eq '2021-10-23'
      expect(booking.confirmed).to eq 0
    end
  end

  describe '#create' do
    it 'adds a new booking to the bookings relation' do
      owner = DatabaseConnection.query("INSERT INTO users(id, username, email, password) VALUES(1, 'Foo', 'foo@bar.com', 'password');")
      customer = DatabaseConnection.query("INSERT INTO users(username, email, password) VALUES('Bar', 'bar@bar.com', 'password');")
      
      # List a space with the user_id set to the owner id
      DatabaseConnection.query("INSERT INTO spaces(id, space_name, description, rate, user_id) VALUES(1, 'Space', 'A lovely home', 50 , 1);")

      Booking.create(space_id: 1, user_id: 1, date_from: '2021-10-20', date_to: '2021-10-23')

      response = DatabaseConnection.query('SELECT * FROM bookings;')
      result = response.first

      expect(result['date_from']).to eq '2021-10-20'
      expect(result['date_to']).to eq '2021-10-23'
      expect(result['space_id']).to eq '1'
      expect(result['user_id']).to eq '1'
      expect(result['confirmed']).to eq '0'
    end
  end

  describe '#find_by_id' do
    it 'will return a booking' do
      owner = DatabaseConnection.query("INSERT INTO users(id, username, email, password) VALUES(1, 'Foo', 'foo@bar.com', 'password');")
      customer = DatabaseConnection.query("INSERT INTO users(username, email, password) VALUES('Bar', 'bar@bar.com', 'password');")
      
      # List a space with the user_id set to the owner id
      DatabaseConnection.query("INSERT INTO spaces(id, space_name, description, rate, user_id) VALUES(1, 'Space', 'A lovely home', 50 , 1);")
      Booking.create(space_id: 1, user_id: 1, date_from: '2021-10-20', date_to: '2021-10-23')
      
      Booking.find_by_id(user_id: 1)
      
      response = DatabaseConnection.query('SELECT * FROM bookings WHERE user_id=1;')
      result = response.first

      expect(result['date_from']).to eq '2021-10-20'
      expect(result['date_to']).to eq '2021-10-23'
      expect(result['space_id']).to eq '1'
      expect(result['user_id']).to eq '1'
      expect(result['confirmed']).to eq '0'
    end
  end
end
