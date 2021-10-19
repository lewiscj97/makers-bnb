# frozen_string_literal: true
require 'space'
require './lib/database_connection'

describe Space do
  describe '#initialize' do
    it 'can be passed an id, space_name, description, rate, user_id' do
      space = Space.new(id: 5, space_name: 'Foo', description: 'A lovely home', rate: 50, user_id: 23)

      expect(space.id).to eq 5
      expect(space.name).to eq 'foo'
      expect(space.description).to eq 'A lovely home'
      expect(space.rate).to eq 50
      expect(space.user_id).to eq 23
    end
  end

  describe '#add_space' do
    it 'should take in a space name, description and rate' do
      Space.add(space_name: 'Foo', description: 'A lovely home', rate: 50)
      space = DatabaseConnection.query('SELECT * FROM spaces')

      expect(space.space_name).to eq 'Foo'
      expect(space.description).to eq 'A lovely home'
      expect(space.rate).to eq 50
    end
  end
end
