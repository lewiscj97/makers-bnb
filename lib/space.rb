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

  def self.add(space_name:, description:, rate:, user_id: nil)
    result = DatabaseConnection.query(
      'INSERT INTO spaces (space_name, description, rate, user_id) VALUES($1, $2, $3, $4) RETURNING id, space_name, description, rate, user_id;',
      [space_name, description, rate, user_id]
    )

    space = result.first
    Space.new(id: space['id'], space_name: space['space_name'], description: space['description'],
              rate: space['rate'], user_id: space['user_id'])
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM spaces;')
    result.map do |value|
      Space.new(id: value['id'], space_name: value['space_name'],
                description: value['description'], rate: value['rate'], user_id: value['user_id'])
    end
  end

  def self.find(id)
    result = DatabaseConnection.query('SELECT * FROM spaces WHERE id=$1;', [id])
    space = result.first
    Space.new(id: space['id'], space_name: space['space_name'],
              description: space['description'], rate: space['rate'], user_id: space['user_id'])
  end
end
