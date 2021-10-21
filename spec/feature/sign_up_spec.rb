# frozen_string_literal: true

feature 'Sign up: ' do
  scenario 'Page will have a title' do
    visit('/sign-up')
    expect(page).to have_content('Sign Up')
  end

  scenario 'Page will have a sign up form' do
    visit('/sign-up')
    expect(page).to have_content('Create a username')
    expect(page).to have_content('Enter an email address')
    expect(page).to have_content('Create a password')
    expect(page).to have_button('Sign up')
  end

  scenario 'Confirmation message shown when user signs up' do
    DatabaseConnection.query("INSERT INTO users(username, email, password) VALUES('Foo', 'foo@bar.com', 'password');")

    visit('/sign-up')
    fill_in 'username', with: 'Foo'
    fill_in 'email', with: 'foo@bar.com'
    fill_in 'password', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content('Congratulations, you have successfully signed up to Makers BnB! You are now signed in!')
    expect(page).to have_current_path('/')
  end
end
