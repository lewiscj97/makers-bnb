feature 'Homepage: ' do
  scenario 'has a naviagtion bar' do
    visit('/')
    expect(page).to have_link('Home')
    expect(page).to have_link('Sign in')
    expect(page).to have_link('View spaces')
    expect(page).to have_link('Add a space')
  end

  scenario 'a user can view the homepage' do
    visit('/')
    click_link('Home')
    expect(page).to have_current_path('/')
  end 

  scenario 'a user can sign in' do
    visit('/')
    click_link('Sign in')
    expect(page).to have_current_path('/sign-in')
  end 

  scenario 'a user can view spaces' do
    visit('/')
    click_link('View spaces')
    expect(page).to have_current_path('/spaces')
  end 

  scenario 'a user can add a space' do
    visit('/')
    click_link('Add a space')
    expect(page).to have_current_path('/add-space')
  end 
end