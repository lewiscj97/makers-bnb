# frozen_string_literal: true

# # frozen_string_literal: true

feature 'view a specific space: ' do
  scenario 'it should return space_name, description and rate when found' do
    add_a_space

    visit('/spaces')
    within("section[@id='0']") do
      click_link('Foo')
    end

    expect(page).to have_content('Foo')
    expect(page).to have_content('Description: A lovely home')
    expect(page).to have_content('£50 per night')
  end
end
