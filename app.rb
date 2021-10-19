require 'sinatra'
require 'database_connection_setup'

class MakersBnb < Sinatra::Base
  get '/test' do
    'Hello, world!'
  end
end
