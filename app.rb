# frozen_string_literal: true

require 'sinatra'
require 'sinatra/flash'
require './lib/database_connection_setup'
require './lib/user'
require './lib/space'

class MakersBnb < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    erb(:index)
  end

  get '/sign-up' do
    erb(:sign_up)
  end

  post '/sign-up' do
    User.create(params['username'], params['email'], params['password'])
    redirect('/sign-up-completed')
  end

  get '/sign-up-completed' do
    erb(:sign_up_completed)
  end

  get 'space/:id' do
    erb(:view_specific_space)
  end

  get '/add-space' do
    erb(:add_space)
  end

  post '/add-space' do
    Space.add(space_name: params[:space_name], description: params[:description], rate: params[:rate])
    redirect('/add-space-confirmation')
  end

  get '/add-space-confirmation' do
    @spaces = DatabaseConnection.query('SELECT * FROM spaces WHERE id = $1;', [params[:id]])
    erb(:add_space_confirmation)
  end

  get '/sign-in' do
    erb :sign_in
  end

  post '/sign-in-input' do 
    email = params['email']
    password = params['password']
    if User.sign_in(email, password) == true
      redirect '/'
    else
      flash[:incorrect_details] = 'Incorrect login details entered'
      redirect '/sign-in'
    end
  end

  get '/spaces' do
    @spaces = Space.all
    erb(:spaces)
  end
end
