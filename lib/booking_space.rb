class BookingSpace
  attr_reader :id, :space_id, :user_id, :date_from, :date_to, :confirmed
  
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
    results = DatabaseConnection.query('
    SELECT bookings.id, date_from, date_to, confirmed, space_name, description, rate, bookings.user_id FROM users
    JOIN spaces ON users.id=spaces.user_id
    JOIN bookings ON spaces.user_id = users.id
    WHERE users.id = $1
    ;', [customer_id])
    results.map do |value|
      BookingSpace.new(id: value['id'], date_from: value['date_from'], date_to: value['date_to'], confirmed: value['confirmed'],
                    space_name: value['space_name'], description: value['description'], rate: value['rate'], customer_id: value['customer_id'])
    end
  end
end
