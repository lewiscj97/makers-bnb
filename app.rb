# frozen_string_literal: true

require 'sinatra'
require './lib/database_connection_setup'
require './lib/user'
require './lib/space'

class MakersBnb < Sinatra::Base
  get '/' do
    erb(:index)
  end

  get '/sign-up' do
    erb(:sign_up)
  end

  post '/sign-up' do
    p params
    User.create(params['username'], params['email'], params['password'])
    redirect('/sign-up-completed')
  end

  get '/sign-up-completed' do
    erb(:sign_up_completed)
  end

  get '/add-space' do
    erb(:add_space)
  end

  post '/add-space' do
    Space.add(space_name: params[:space_name], description: params[:description], rate: params[:rate])
    redirect('/add-space-confirmation')
  end

  get '/add-space-confirmation' do
    erb(:add_space_confirmation)
  end

  post '/sign-in' do
    erb :sign_in
  end

  post '/sign-in-input' do
    User.sign_in
    redirect '/'
  end

end
