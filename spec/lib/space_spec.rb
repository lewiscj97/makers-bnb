# frozen_string_literal: true

require './lib/database_connection'
require './lib/space'

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
      expect(space['rate']).to eq '50'
    end
  end

  describe '#all' do
    it 'returns one space from database' do
      Space.add(space_name: 'Foo', description: 'A lovely home', rate: 50)
      spaces = Space.all
      expect(spaces[0].space_name).to eq 'Foo'
      expect(spaces[0].description).to eq 'A lovely home'
      expect(spaces[0].rate).to eq '50'
    end

    it 'returns multiple spaces from database' do
      Space.add(space_name: 'Foo', description: 'A lovely home', rate: 50)
      Space.add(space_name: 'Bar', description: 'A lovely home', rate: 50)
      Space.add(space_name: 'Test', description: 'A lovely home', rate: 50)
      spaces = Space.all
      expect(spaces[0].space_name).to eq 'Foo'
      expect(spaces[1].space_name).to eq 'Bar'
      expect(spaces[2].space_name).to eq 'Test'
    end
  end

  describe '#find' do
    it 'should return a specific space based on a space.id' do
      Space.add(space_name: 'Foo', description: 'A lovely home', rate: 50)
      data = PG.connect(dbname: 'makersbnb_test').query("SELECT * FROM spaces;")

      space_id = data.first['id']
      
      space = Space.find(space_id)
      expect(space.id).to eq space_id
      expect(space.space_name).to eq 'Foo'
    end
  end
end
