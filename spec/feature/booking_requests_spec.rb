feature 'View my booking requests' do
  context 'a booking request for a users space is made' do
    scenario 'the booking request is visible for the user' do
      make_a_booking
      user_sign_in

      click_link('My Requests')

      expect(page).to have_content('Space')
      expect(page).to have_content('A lovely home')
      expect(page).to have_content('£50ppn')
      expect(page).to have_content('2021-10-20')
      expect(page).to have_content('2021-10-25')
    end
  end
end

feature 'Approve a booking request' do
  context 'a booking request is made' do
    scenario 'the owner approves' do 
      make_a_booking
      user_sign_in

      click_link('My Requests')
      click_button('Approve')

      expect(page).to have_content("Confirmed bookings\nSpace\nA lovely home\n£50ppn")
    end
  end
end
