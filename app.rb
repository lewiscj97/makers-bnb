require 'sinatra'
require './lib/database_connection_setup'

class MakersBnb < Sinatra::Base
  get '/test' do
    'Hello, world!'
  end

  get '/sign-up' do
    erb (:sign_up)
  end
end
