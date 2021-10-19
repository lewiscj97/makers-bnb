feature 'add a space: ' do
  scenario 'it should add a space to the database' do
    visit('/add-space')
    expect(page).to have_content('Makers BnB\nAdd a Space\nSpace Name: Description: Nightly Rate:')
  end
end
