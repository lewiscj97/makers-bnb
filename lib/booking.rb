class Booking
  attr_reader :id, :space_id, :user_id, :date_from, :date_to, :confirmed
  
  def initialize(id:, space_id:, user_id:, date_from:, date_to:, confirmed: 0)
    @id = id
    @space_id = space_id
    @user_id = user_id
    @date_from = date_from
    @date_to = date_to
    @confirmed = confirmed
  end

  def self.create(space_id:, user_id:, date_from:, date_to:)
    DatabaseConnection.query(
      'INSERT INTO bookings(space_id, user_id, date_from, date_to, confirmed)
      VALUES($1, $2, $3, $4, $5);', [space_id, user_id, date_from, date_to, 0]
    )
  end

  def self.find_by_id(user_id)
    result = DatabaseConnection.query('SELECT * FROM bookings WHERE user_id=$1;', [user_id])
    result.map do |value|
      Booking.new(id: value['id'], space_id: value['space_id'], user_id: value['user_id'],
      date_from: value['date_from'], date_to: value['date_to'], confirmed: value['confirmed'])
    end
  end
end
