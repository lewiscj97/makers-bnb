feature 'add a space: ' do
  scenario 'it should add a space to the database' do
    visit('/add-space')
    expect(page).to have_content('Space successfully added!')
  end
end
