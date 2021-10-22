class BookingSpace
  attr_reader :id, :space_name, :date_from, :date_to, :confirmed, :description, :rate, :customer_id
  
  def initialize(id:, date_from:, date_to:, confirmed: 0, space_name:, description:, rate:, customer_id:)
    @id = id
    @date_from = date_from
    @date_to = date_to
    @confirmed = confirmed
    @space_name = space_name
    @description = description
    @rate = rate
    @customer_id = customer_id
  end

  def self.get_by_id(customer_id)
    result = DatabaseConnection.query(
      'SELECT bookings.id, date_from, date_to, confirmed, space_name, description, rate, bookings.user_id FROM bookings
      JOIN spaces ON bookings.space_id=spaces.id
      JOIN users on spaces.user_id = users.id
      WHERE users.id = $1;', [customer_id])
    result.map do |booking|
      BookingSpace.new(id: booking['id'], date_from: booking['date_from'], date_to: booking['date_to'], confirmed: booking['confirmed'],
                    space_name: booking['space_name'], description: booking['description'], rate: booking['rate'], customer_id: booking['user_id'])
    end
  end

  def self.approve_request(booking_id)
    DatabaseConnection.query(
      "UPDATE bookings SET confirmed='1' WHERE id=$1;",
      [booking_id]
    )
  end

  def self.reject_request(booking_id)
    DatabaseConnection.query('DELETE FROM bookings WHERE id=$1;', [booking_id])
  end
end
