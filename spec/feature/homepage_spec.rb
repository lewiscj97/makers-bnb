# frozen_string_literal: true

feature 'Homepage: ' do
  scenario 'has a navigation bar' do
    visit('/spaces')
    expect(page).to have_link('Sign in')
  end

  scenario 'a user can view the homepage' do
    visit('/spaces')
    click_link('Makers BnB')
    expect(page).to have_current_path('/spaces')
  end

  scenario 'a user can sign in' do
    visit('/spaces')
    click_link('Sign in')
    expect(page).to have_current_path('/sign-in')
  end

  scenario 'a user can view spaces' do
    user_sign_up
    expect(page).to have_current_path('/spaces')
  end

  scenario 'a user can view their listings' do
    user_sign_up
    user_id = User.get_user_id('foo@bar.com')

    visit('/spaces')
    click_link('My Listings')
    expect(page).to have_current_path("/#{user_id}/spaces")
  end

  scenario 'username is displayed when signed in' do
    user_sign_in_sign_out_helper

    expect(page).to have_content('Foo')
  end

  scenario "only show 'add a space' if the user is signed in" do
    visit('/spaces')
    expect(page).to_not have_content('Add a space')

    user_sign_in_sign_out_helper
    expect(page).to have_content('Add a space')

    click_link('Add a space')
    expect(page).to have_current_path('/add-space')
  end

  scenario "only show 'my listings' if the user is signed in" do
    visit('/spaces')
    expect(page).to_not have_content('My Listings')

    user_sign_in_sign_out_helper
    id = User.get_user_id('foo@bar.com')
    expect(page).to have_content('My Listings')

    click_link('My Listings')
    expect(page).to have_current_path("/#{id}/spaces")
  end
end
