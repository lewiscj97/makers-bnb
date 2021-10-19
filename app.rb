require 'sinatra'
require './lib/database_connection_setup'
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

  post '/add-space' do
    Space.add(space_name: params[:space_name], description: params[:description], rate: params[:rate])
    redirect '/add-space'
  end
end
