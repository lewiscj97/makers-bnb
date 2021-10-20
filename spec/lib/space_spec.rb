# frozen_string_literal: true
require 'space'

describe Space do
  describe '#initialize' do
    it 'can be passed an id, space_name, description, rate, user_id' do
      space = Space.new(id: 5, space_name: 'Foo', description: 'A lovely home', rate: 50, user_id: 23)

      expect(space.id).to eq 5
      expect(space.space_name).to eq 'Foo'
      expect(space.description).to eq 'A lovely home'
      expect(space.rate).to eq 50
      expect(space.user_id).to eq 23
    end
  end

  describe '#add_space' do
    it 'should take in a space name, description and rate' do
      Space.add(space_name: 'Foo', description: 'A lovely home', rate: 50)
      response = DatabaseConnection.query('SELECT * FROM spaces;')
      space = response.first

      expect(space['space_name']).to eq 'Foo'
      expect(space['description']).to eq 'A lovely home'
      expect(space['rate']).to eq "50"
    end
  end

  describe '#all' do
    it 'returns one spaces from database' do
      add_a_space
      spaces = Space.all

      expect(spaces[0].space_name).to eq 'foo'
    end
  end
end
