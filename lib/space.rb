# frozen_string_literal: true

require './lib/database_connection'
require './lib/database_connection_setup'

class Space
  def initialize(id:, space_name:, description:, rate:, user_id:)
    @id = id
    @space_name = space_name
    @description = description
    @rate = rate
    @user_id = user_id
  end

  attr_reader :id, :space_name, :description, :rate, :user_id

  def self.add(space_name:, description:, rate:)
    DatabaseConnection.setup('makersbnb')
    result = DatabaseConnection.query(
      'INSERT INTO spaces (space_name, description, rate) VALUES($1, $2, $3) RETURNING space_name, description, rate;',
      [space_name, description, rate]
    )

    Space.new(id: result[0]['id'], space_name: result[0]['name'], description: result[0]['description'],
              rate: result[0]['rate'], user_id: result[0]['user_id'])
  end
end
