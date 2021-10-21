# frozen_string_literal: true

feature 'User is signed in, creates a space' do
  scenario 'The user id is added to the spaces table' do
    user_sign_up
    id = User.get_user_id('foo@bar.com')
    add_a_space

    response = DatabaseConnection.query("SELECT * FROM spaces WHERE space_name='Foo'")
    space = response.first

    expect(space['user_id']).to eq id

    visit("/#{id}/spaces")

    expect(page).to have_content 'Foo'
    expect(page).to have_content 'A lovely home'
    expect(page).to have_content 50
  end
end
