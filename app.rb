require 'sinatra'
require './lib/database_connection_setup'
require './lib/user.rb'
require './lib/space'

class MakersBnb < Sinatra::Base
  get '/test' do
    'Hello, world!'
  end

  get '/' do
    erb :index
  end

  get '/add-space' do
    erb :add_space
  end

  get '/add-space-confirmation' do
    erb :add_space_confirmation
  end

  post '/add-space' do
    Space.add(space_name: params[:space_name], description: params[:description], rate: params[:rate])
    redirect '/add-space-confirmation'
  end
end
