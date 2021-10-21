# frozen_string_literal: true

feature 'Sign in to your user account: ' do
  scenario 'User is able to log in to their account' do
    DatabaseConnection.query("INSERT INTO users(username, email, password) VALUES('Foo', 'foo@bar.com', 'password');")

    user_sign_in

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
    fill_in 'email', with: 'foo1@bar.com'
    fill_in 'password', with: 'password'
    click_button 'Log in'

    expect(page).to have_current_path('/sign-in')
  end

  scenario 'User is taken to sign up page when clicking the sign-up button' do
    visit('/sign-in')
    click_button 'Sign up'

    expect(page).to have_current_path('/sign-up')
  end

  scenario 'Error message shown when user signs in unsuccessfully' do
    DatabaseConnection.query("INSERT INTO users(username, email, password) VALUES('Foo', 'foo@bar.com', 'password');")

    visit('/sign-in')
    fill_in 'email', with: 'foo@bar.com'
    fill_in 'password', with: 'incorrectpassword'
    click_button 'Log in'

    expect(page).to have_content('Incorrect login details entered')
  end

  scenario 'Message shown when user signs' do
    DatabaseConnection.query("INSERT INTO users(username, email, password) VALUES('Foo', 'foo@bar.com', 'password');")

    user_sign_in

    expect(page).to have_content('You have successfully logged in!')
    expect(page).to have_current_path('/')
  end
end
