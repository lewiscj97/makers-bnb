require 'booking_space'

describe BookingSpace do
  describe '#get_by_id' do
    it 'can join bookings and spaces table and return values' do
      make_a_booking

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

  describe '#approve_request' do
    it 'confirms a booking request' do
      make_a_booking
      booking = BookingSpace.get_by_id(1).first
      booking_id = booking.id

      BookingSpace.approve_request(booking_id)

      response = DatabaseConnection.query(
        'SELECT bookings.id, date_from, date_to, confirmed, space_name, description, rate, bookings.user_id FROM users
        JOIN spaces ON users.id=spaces.user_id
        JOIN bookings ON spaces.user_id = users.id
        WHERE users.id = 1'
      )
      result = response.first
      
      expect(result['confirmed']).to eq '1'
    end
  end
end
