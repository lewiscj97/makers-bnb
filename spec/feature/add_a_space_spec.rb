# frozen_string_literal: true

feature 'Add a space: ' do
  scenario 'It should add a space to the database' do
    add_a_space
    expect(page).to have_current_path('/add-space-confirmation')
    expect(page).to have_content('Successfully added a space!')
    expect(page).to have_button('Add Another Space')
  end
end

feature 'User is signed in, creates a space' do
  scenario 'The user id is added to the spaces table' do
    # Add user to database
    DatabaseConnection.query("INSERT INTO users(username, email, password) VALUES('Foo', 'foo@bar.com', 'password');")
    id = User.get_user_id('foo@bar.com')

    # Sign in
    visit('/sign-in')

    fill_in 'email', with: 'foo@bar.com'
    fill_in 'password', with: 'password'
    click_button 'Log in'

    expect(page).to have_current_path('/')

    # Add a new space
    click_on('Add a space')
    fill_in 'space_name', with: 'Foo'
    fill_in 'description', with: 'A lovely home'
    fill_in 'rate', with: 50
    click_button 'Add Space'

    # Redirect and see a flash message
    expect(page).to have_content('You have successfully added a space!')
    expect(page).to have_current_path("/spaces/#{space_id}")

    # Get the space details for checking
    response = DatabaseConnection.query("SELECT * FROM spaces WHERE space_name='Foo'")
    space = response.first

    expect(space['user_id']).to eq id
  end
end
