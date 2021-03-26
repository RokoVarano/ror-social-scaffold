# rubocop:disable Metrics/BlockLength
require 'rails_helper'
RSpec.feature 'Users', type: :feature do
  context 'Validate User Sign up' do
    before(:each) do
      user = User.new(name: 'TestGuy', email: 'test@example.com', password: 'password',
                      password_confirmation: 'password')
      user.save

      visit '/users/sign_up'
      within '.new_user' do
        fill_in 'user_name', with: 'clownsman'
        fill_in 'user_email', with: 'clownsman@gmail.com'
        fill_in 'user_password', with: 'clownpass'
        fill_in 'user_password_confirmation', with: 'clownpass'
      end
    end

    scenario 'should succeed' do
      click_button 'Sign up'
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end

    scenario 'should fail with no username' do
      within '.new_user' do
        fill_in 'user_name', with: ''
      end
      click_button 'Sign up'
      expect(page).to have_content("Name can't be blank")
    end

    scenario 'should fail with already existing name' do
      within '.new_user' do
        fill_in 'user_name', with: User.last.name
      end
      click_button 'Sign up'
      expect(page).to have_content('Name has already been taken')
    end

    scenario 'should fail with no email' do
      within '.new_user' do
        fill_in 'user_email', with: ''
      end
      click_button 'Sign up'
      expect(page).to have_content("Email can't be blank")
    end

    scenario 'should fail with already existing email' do
      within '.new_user' do
        fill_in 'user_email', with: User.last.email
      end
      click_button 'Sign up'
      expect(page).to have_content('Email has already been taken')
    end

    scenario 'should fail with password < 6 chars' do
      within '.new_user' do
        fill_in 'user_password', with: '12345'
      end
      click_button 'Sign up'
      expect(page).to have_content('Password is too short (minimum is 6 characters)')
    end

    scenario 'should fail with no password' do
      within '.new_user' do
        fill_in 'user_password', with: ''
      end
      click_button 'Sign up'
      expect(page).to have_content("Password can't be blank")
    end

    scenario 'should fail if password != password_confirmation' do
      within '.new_user' do
        fill_in 'user_password', with: '123456'
        fill_in 'user_password_confirmation', with: '123465'
      end
      click_button 'Sign up'
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end

  context 'Validate User Log In' do
    before(:each) do
      user = User.new(name: 'TestGuy', email: 'test@example.com', password: 'password',
                      password_confirmation: 'password')
      user.save

      visit '/users/sign_in'
    end

    scenario 'should succeed' do
      within '.new_user' do
        fill_in 'user_email', with: User.last.email
        fill_in 'user_password', with: 'password'
      end
      click_button 'Log in'
      expect(page).to have_content('Signed in successfully.')
    end

    scenario 'should succeed if page is root path' do
      within '.new_user' do
        fill_in 'user_email', with: User.last.email
        fill_in 'user_password', with: 'password'
      end
      click_button 'Log in'
      expect(page).to have_current_path(root_path)
    end

    scenario 'should fail with non-existing email' do
      within '.new_user' do
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: 'password'
      end
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password')
    end

    scenario 'should fail with non-existing password' do
      within '.new_user' do
        fill_in 'user_email', with: User.last.email
        fill_in 'user_password', with: ''
      end
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password')
    end

    scenario 'should fail with wrong email' do
      within '.new_user' do
        fill_in 'user_email', with: 'dumb@example.com'
        fill_in 'user_password', with: 'password'
      end
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password')
    end

    scenario 'should fail with incomplete email' do
      within '.new_user' do
        fill_in 'user_email', with: 'test@example'
        fill_in 'user_password', with: 'password'
      end
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password')
    end

    scenario 'should fail with wrong password' do
      within '.new_user' do
        fill_in 'user_email', with: User.last.email
        fill_in 'user_password', with: 'wrong'
      end
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password')
    end
  end
end
# rubocop:enable Metrics/BlockLength
