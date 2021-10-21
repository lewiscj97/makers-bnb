# frozen_string_literal: true

def drop_test_db
  p 'Setting up test database...'
  connection = PG.connect(dbname: 'makersbnb_test')
  # Clear the tables
  connection.exec('TRUNCATE users;')
  connection.exec('TRUNCATE spaces;')
  connection.exec('TRUNCATE bookings;')
end

def user_sign_in
  visit('/sign-in')
  fill_in :email, with: 'foo@bar.com'
  fill_in :password, with: 'password'
  click_button 'Log in'
end

def user_sign_up
  visit('/sign-up')
  fill_in :username, with: 'Foo'
  fill_in :email, with: 'foo@bar.com'
  fill_in :password, with: 'password'
  click_button 'Sign up'
end

def add_a_space
  visit('/add-space')
  fill_in 'space_name', with: 'Foo'
  fill_in 'description', with: 'A lovely home'
  fill_in 'rate', with: 50
  click_button 'Add Space'
end
