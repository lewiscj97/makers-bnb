feature 'View my booking requests' do
  context 'a booking request for a users space is made' do
    scenario 'the booking request is visible for the user' do
      owner = DatabaseConnection.query("INSERT INTO users(id, username, email, password) VALUES(1, 'Foo', 'foo@bar.com', 'password');")
      customer = DatabaseConnection.query("INSERT INTO users(id, username, email, password) VALUES(2, 'Bar', 'bar@bar.com', 'password');")
      DatabaseConnection.query("INSERT INTO spaces(id, space_name, description, rate, user_id) VALUES(1, 'Space', 'A lovely home', 50 , 1);")
      DatabaseConnection.query("INSERT INTO bookings(space_id, user_id, date_from, date_to, confirmed) VALUES(1, 2, '2021-10-20', '2021-10-25', '0');")

      user_sign_in
      click_link('My Requests')

      expect(page).to have_content('Space')
      expect(page).to have_content('A lovely home')
      expect(page).to have_content('£50')
      expect(page).to have_content('2021-10-20')
      expect(page).to have_content('2021-10-25')
    end
  end
end
