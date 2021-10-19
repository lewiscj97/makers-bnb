feature 'Sign in to your user account:' do
  scenario 'User is able to log in to their account' do
    DatabaseConnection.query("INSERT INTO users(username, email, password) VALUES('Foo', 'foo@bar.com, 'password');")

    visit('/sign-in')
    fill_in 'email', with: 'foo@bar.com'
    fill_in 'password', with: 'password'
    click_button 'Log in'

    expect(page).to have_content('You have successfully logged in!')
  end
end
