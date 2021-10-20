feature 'add a space: ' do
  scenario 'it should add a space to the database' do
    add_a_space
    expect(page).to have_current_path('/add-space-confirmation')
    expect(page).to have_content('Successfully added a space!')
    expect(page).to have_button('Add Another Space')
    expect(page).to have_button('View Your Space')
  end
end
