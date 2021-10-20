feature 'view all spaces' do
    scenario 'Able to view a list of spaces' do
        add_a_space
        visit('/spaces')
        expect(page).to have_content('Foo')
    end
end