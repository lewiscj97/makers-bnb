# frozen_string_literal: true

feature 'User is signed in, creates a space' do
  scenario 'The user id is added to the spaces table' do
    # Add user to database
    DatabaseConnection.query("INSERT INTO users(username, email, password) VALUES('Foo', 'foo@bar.com', 'password');")
    id = User.get_user_id('foo@bar.com')

    # Sign in
    user_sign_in

    expect(page).to have_current_path('/spaces')

    # Add a new space
    add_a_space

    # Get the space details for checking
    response = DatabaseConnection.query("SELECT * FROM spaces WHERE space_name='Foo'")
    space = response.first

    expect(space['user_id']).to eq id

    # Redirect and see a flash message
    expect(page).to have_content('You have successfully added a space!')
    expect(page).to have_current_path("/spaces/#{space['id']}")
  end
end
