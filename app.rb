require 'sinatra'
require './lib/database_connection_setup'

class MakersBnb < Sinatra::Base
  get '/test' do
    'Hello, world!'
  end

  get '/' do
    erb :index
  end

end
