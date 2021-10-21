class BookingSpace
  attr_reader :id, :space_id, :user_id, :date_from, :date_to, :confirmed
  
  def initialize(id:, space_id:, user_id:, date_from:, date_to:, confirmed: 0)
    @id = id
    @date_from = date_from
    @date_to = date_to
    @confirmed = confirmed
    @space_name = space_name
    @description = description
    @rate = rate
  end

  def self.get_by_id(user_id)
    results = DatabaseConnection.query('SELECT bookings.id, date_from, date_to, confirmed, space_name, description, rate FROM bookings JOIN spaces ON bookings.space_id = spaces.id WHERE spaces.user_id = $1;', [user_id])
    result.map do |value|
      BookingSpace.new(id: value['id'], date_from: value['date_from'], date_to: value['date_to'], confirmed: value['confirmed'],
                    space_name: value['space_name'], description: value['description'], rate: value['rate'])
    end
  end

end