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
end
