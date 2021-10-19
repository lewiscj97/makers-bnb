feature 'add a space: ' do
  scenario 'it should add a space to the database' do
    visit('/add-space')

    fill_in 'space_name', with: 'Foo'
    fill_in 'description', with: 'A lovely home'
    fill_in 'rate', with: 50
    click_button 'Add Space'

    expect(page).to have_current_path('/add-space-confirmation')
    expect(page).to have_content('Successfully added a space!')
  end
end
