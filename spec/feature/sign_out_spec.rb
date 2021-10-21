feature 'Signing out:' do
  context 'A user is logged in' do
    before(:each) { user_sign_in_sign_out_helper }

    scenario 'A logged in user is shown the sign out button' do
      expect(page).to have_content('Sign out')
      expect(page).to_not have_content('Sign in')
    end

    scenario 'Clicking sign out signs the user out' do
      click_on 'Sign out'
      expect(page).to have_content('Sign in')
      expect(page).to have_content('You have signed out')
    end
  end
end
