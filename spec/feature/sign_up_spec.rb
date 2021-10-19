feature 'Sign up: ' do
  scenario 'page will have a title' do
    visit('/sign-up')
    expect(page).to have_content('Sign Up')
  end

  scenario 'page will have a sign up form' do
    visit('/sign-up')
    expect(page).to have_content('Enter your name')
    expect(page).to have_content('Enter your email address')
    expect(page).to have_content('Create your password')
    expect(page).to have_button('Submit')
  end

  scenario 'a user can sign up' do
    visit('/sign-up')
    page.fill_in :name, with: 'Brian'
    page.fill_in :email, with: 'test@email.com'
    page.fill_in :password, with: 'password123'
    page.click_button 'Submit'
    expect(page).to 
  end
end