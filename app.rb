require 'sinatra'
require './lib/database_connection_setup'
require './lib/user.rb'

class MakersBnb < Sinatra::Base
  get '/test' do
    'Hello, world!'
  end

  get '/sign-up' do
    erb (:sign_up)
  end

  post '/sign-up' do
    p params
    User.create(params['username'], params['email'], params['password'])
    redirect ('/sign-up-completed')
  end

  get '/sign-up-completed' do
    erb (:sign_up_completed)
  end
  
  get '/' do
    erb :index
  end

end
