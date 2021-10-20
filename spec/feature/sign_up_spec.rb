# frozen_string_literal: true

feature 'Sign up: ' do
  scenario 'page will have a title' do
    visit('/sign-up')
    expect(page).to have_content('Sign Up')
  end

  scenario 'page will have a sign up form' do
    visit('/sign-up')
    expect(page).to have_content('Create a username')
    expect(page).to have_content('Enter an email address')
    expect(page).to have_content('Create a password')
    expect(page).to have_button('Submit')
  end

  scenario 'a user can sign up' do
    user_sign_up
    expect(page).to have_current_path('/sign-up-completed')
    expect(page).to have_content('You have created an account.')
  end
end
