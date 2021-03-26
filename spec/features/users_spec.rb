# rubocop:disable Metrics/BlockLength
require 'rails_helper'
RSpec.feature 'Users', type: :feature do
  before(:each) do
    visit '/users/sign_up'
  end

  context 'Validate User Sign up' do
    scenario 'should succeed' do
      within '.new_user' do
        fill_in 'user_name', with: 'clownsman'
        fill_in 'user_email', with: 'clownsman@gmail.com'
        fill_in 'user_password', with: 'clownpass'
        fill_in 'user_password_confirmation', with: 'clownpass'
      end
      click_button 'Sign up'
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
  end

end