feature 'Making a booking' do
  before(:each) do
    DatabaseConnection.query(
      "INSERT INTO spaces(id, space_name, description, rate, user_id) VALUES(1, 'Space', 'A lovely home', 50 , 1);"
    )
  end
  scenario 'User makes a booking request for a space' do
    # Create two users
    owner = DatabaseConnection.query("INSERT INTO users(id, username, email, password) VALUES(1, 'Foo', 'foo@bar.com', 'password');")
    customer = DatabaseConnection.query("INSERT INTO users(username, email, password) VALUES('Bar', 'bar@bar.com', 'password');")
    
    # Sign in
    visit('/sign-in')
    fill_in 'email', with: 'foo@bar.com'
    fill_in 'password', with: 'password'
    click_button 'Log in'

    visit('/spaces/1')
    fill_in 'date_from', with: '2021-10-20'
    fill_in 'date_to', with: '2021-10-23'
    click_button 'Submit Request'

    response = DatabaseConnection.query('SELECT * FROM bookings WHERE space_id=1')
    result = response.first

    expect(result['date_from']).to eq '2021-10-20'
    expect(result['date_to']).to eq '2021-10-23'
    expect(result['space_id']).to eq '1'
    expect(result['user_id']).to eq '1'
    expect(result['confirmed']).to eq '0'
  end

  scenario 'User cannot request a booking if they are not signed in' do
    # Makes a request without being signed in
    visit('/spaces/1')
    fill_in 'date_from', with: '2021-10-20'
    fill_in 'date_to', with: '2021-10-23'
    click_button 'Submit Request'

    result = DatabaseConnection.query('SELECT * FROM bookings;')

    expect(page).to have_content 'You must be signed in to make a booking request'
    expect(result.first).to eq nil
  end

  scenario 'User must enter both dates in order to make a requst' do
    # Makes a request without being signed in
    visit('/spaces/1')
    fill_in 'date_from', with: '2021-10-20'
    click_button 'Submit Request'

    result = DatabaseConnection.query('SELECT * FROM bookings;')

    expect(result.first).to eq nil
    expect(page).to have_current_path('/spaces/1')
  end
end
