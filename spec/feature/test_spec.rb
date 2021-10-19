feature 'test:' do
  scenario 'shown a test message' do
    visit('/test')
    expect(page).to have_content('Hello, world!')
  end
end
