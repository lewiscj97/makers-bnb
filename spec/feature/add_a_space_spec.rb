# frozen_string_literal: true

feature 'Add a space: ' do
  scenario 'It should add a space to the database' do
    add_a_space
    expect(page).to have_current_path('/add-space-confirmation')
    expect(page).to have_content('Successfully added a space!')
    expect(page).to have_button('Add Another Space')
    expect(page).to have_button('View Your Space')
  end
end
