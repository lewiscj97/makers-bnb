require 'sinatra'
require './lib/database_connection_setup'

class MakersBnb < Sinatra::Base
  get '/test' do
    'Hello, world!'
  end

  get '/' do
    erb :index
  end

  post '/sign-in' do
    erb :sign_in
  end

  post '/sign-in-input' do
    User.sign_in
    redirect '/'
  end

end
