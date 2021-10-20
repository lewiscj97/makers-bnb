# frozen_string_literal: true

require './lib/database_connection'

if ENV['ENVIRONMENT'] == 'test'
  DatabaseConnection.setup('makersbnb_test')
else
  # :nocov:
  DatabaseConnection.setup('makersbnb')
  # :nocov:
end
