feature 'Sign in to your user account:' do
  scenario 'User is able to log in to their account' do
    DatabaseConnection.query("INSERT INTO users(username, email, password) VALUES('Foo', 'foo@bar.com', 'password');")

    visit('/sign-in')
    fill_in 'email', with: 'foo@bar.com'
    fill_in 'password', with: 'password'
    click_button 'Log in'

    expect(page).to have_current_path('/')
  end

  scenario 'User is not able to login if their password is incorrect' do
    DatabaseConnection.query("INSERT INTO users(username, email, password) VALUES('Foo', 'foo@bar.com', 'password');")

    visit('/sign-in')
    fill_in 'email', with: 'foo@bar.com'
    fill_in 'password', with: 'incorrectpassword'
    click_button 'Log in'

    expect(page).to have_current_path('/sign-in')
  end

  scenario 'User email not in database' do
    visit('/sign-in')
    fill_in 'email', with: 'foo@bar.com'
    fill_in 'password', with: 'password'
    click_button 'Log in'

    expect(page).to have_current_path('/sign-in')
  end

  scenario 'User is taken to sign up page when clicking the sign-up button' do
    visit('/sign-in')
    click_button 'Sign up'

    expect(page).to have_current_path('/sign-up')
  end
end
