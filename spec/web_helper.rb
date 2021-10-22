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
  click_button 'Sign in'
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

def user_sign_in_sign_out_helper
  DatabaseConnection.query("INSERT INTO users(username, email, password) VALUES('Foo', 'foo@bar.com', 'password');")
  user_sign_in
end

def make_a_booking
  owner = DatabaseConnection.query("INSERT INTO users(id, username, email, password) VALUES(1, 'Foo', 'foo@bar.com', 'password');")
  customer = DatabaseConnection.query("INSERT INTO users(id, username, email, password) VALUES(2, 'Bar', 'bar@bar.com', 'password');")
  DatabaseConnection.query("INSERT INTO spaces(id, space_name, description, rate, user_id) VALUES(1, 'Space', 'A lovely home', 50 , 1);")
  DatabaseConnection.query("INSERT INTO bookings(space_id, user_id, date_from, date_to, confirmed) VALUES(1, 2, '2021-10-20', '2021-10-25', '0');")
end