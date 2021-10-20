# frozen_string_literal: true

feature 'view a specific space: ' do
  scenario 'it should return space_name, description and rate when found' do
    visit('/add-space')

    fill_in 'space_name', with: 'Foo'
    fill_in 'description', with: 'A lovely home'
    fill_in 'rate', with: 50
    click_button 'Add Space'

    click_button 'View Your Space'

    expect(page).to have_current_path('/spaces/:id')
    expect(page).to have_content('Space Name: Foo')
    expect(page).to have_content('Description: A lovely home')
    expect(page).to have_content('Rate: 50')
  end
end
