# frozen_string_literal: true

require 'sinatra'
require 'sinatra/flash'
require './lib/database_connection_setup'
require './lib/user'
require './lib/space'
require './lib/booking'
require './lib/booking_space'

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
    user = User.create(params['username'], params['email'], params['password'])
    session[:user_id] = user.id
    flash[:sign_up_success] = 'Congratulations, you have successfully signed up to Makers BnB! You are now signed in!'
    session[:username] = User.get_username(params['email'])
    redirect('/spaces')
  end

  get '/add-space' do
    erb(:add_space)
  end

  post '/add-space' do
    @space = Space.add(space_name: params[:space_name], description: params[:description], rate: params[:rate],
              user_id: session[:user_id])
    flash[:add_space_success] = 'You have successfully added a space!'
    redirect("/spaces/#{@space.id}")
  end

  get '/sign-in' do
    erb(:sign_in)
  end

  post '/sign-in-input' do
    email = params['email']
    password = params['password']
    if User.sign_in(email, password) == true
      session[:user_id] = User.get_user_id(email)
      session[:username] = User.get_username(email)
      flash[:sign_in_success] = 'You have successfully signed in!'
      redirect('/spaces')
    else
      flash[:incorrect_details] = 'Incorrect sign in details entered'
      redirect('/sign-in')
    end
  end

  get '/spaces' do
    @spaces = Space.all
    erb(:all_spaces)
  end

  get '/spaces/:id' do
    @space = Space.find(params[:id])
    erb(:view_specific_space)
  end

  get '/:id/spaces' do
    @spaces = Space.my_listings(session[:user_id])
    erb(:all_spaces)
  end

  get '/sign-out' do
    session[:user_id] = nil
    flash[:sign_out] = 'You have successfully signed out!'
    redirect('/spaces')
  end
  
  post '/booking/:id' do
    unless session[:user_id].nil?
      Booking.create(space_id: params['id'], user_id: session[:user_id], date_from: params['date_from'], date_to: params['date_to'])
      flash[:booking_request] = 'Booking request submitted'
      redirect('/spaces')
    else
      flash[:user_not_signed_in] = 'You must be signed in to make a booking request'
      redirect("/spaces/#{params['id']}")
    end
  end

  get '/:user_id/requests' do
    @bookings = BookingSpace.get_by_id(session[:user_id])
    @unconfirmed_bookings = @bookings.select { |request| request.confirmed == '0'}
    @confirmed_bookings = @bookings.select { |request| request.confirmed == '1'}
    erb(:my_requests)
  end

  post '/:booking_id/confirm' do
    BookingSpace.approve_request(params[:booking_id])
    redirect("/#{session[:user_id]}/requests")
  end

  post '/:booking_id/deny' do
    BookingSpace.reject_request(params[:booking_id])
    redirect("/#{session[:user_id]}/requests")
  end
end
