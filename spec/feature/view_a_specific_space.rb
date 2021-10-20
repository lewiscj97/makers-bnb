# # frozen_string_literal: true
#
# feature 'view a specific space: ' do
#   scenario 'it should return space_name, description and rate when found' do
#     add_a_space
#
#     click_button 'View Your Space'
#
#     expect(page).to have_content('Space Name: Foo')
#     expect(page).to have_content('Description: A lovely home')
#     expect(page).to have_content('Rate: 50')
#   end
# end
