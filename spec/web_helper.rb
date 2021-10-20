def drop_test_db
  p "Setting up test database..."
  connection = PG.connect(dbname: 'makersbnb_test')
  # Clear the tables
  connection.exec("TRUNCATE users;")
  connection.exec("TRUNCATE spaces;")
end

def user_sign_up
  visit('/sign-up')
  page.fill_in :username, with: 'Brian'
  page.fill_in :email, with: 'test@email.com'
  page.fill_in :password, with: 'password123'
  page.click_button 'Submit'
end

def add_a_space
  visit('/add-space')
  fill_in 'space_name', with: 'Foo'
  fill_in 'description', with: 'A lovely home'
  fill_in 'rate', with: 50
  click_button 'Add Space'
end