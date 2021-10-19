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

    space = result.first
    Space.new(id: space['id'], space_name: space['name'], description: space['description'],
              rate: space['rate'], user_id: space['user_id'])
  end
end