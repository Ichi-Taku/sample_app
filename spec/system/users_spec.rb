require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe `user create a new account` do
    context `enter an valid values` do
      before do
        visit signup_path
        fill_in 'Name', with: 'testuser'
        fill_in 'Email', with: 'testuser@example.com'
        fill_in 'UserID', with: 'testuserid'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'Create my account'
      end
      it 'gets an flash message' do
        expect(page).to have_selector('.alert-info', text: 'Please check your email to activate your account.')
      end
    end
    context 'enter an invalid values' do
      before do
        visit signup_path
        fill_in 'Name', with: ''
        fill_in 'Email', with: ''
        fill_in 'UserID', with: ''
        fill_in 'Password', with: ''
        fill_in 'Password confirmation', with: ''
        click_button 'Create my account'
      end
      subject { page }
      it 'gets an errors' do
        is_expected.to have_selector('#error_explanation')
        is_expected.to have_selector('.alert-danger', text: 'The form contains 5 errors.')
        is_expected.to have_content("Password can't be blank")
      end
      it 'render to /signup url' do
        is_expected.to have_current_path '/signup'
      end
    end
  end

  describe `user edit my account data` do
    let!(:user) { create(:user) }
    before do
      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: "password"
      click_button 'Log in'

      visit edit_user_path(user)
      fill_in 'Name', with: ''
      fill_in 'Email', with: ''
      fill_in "UserID", with: ""
      fill_in 'Password', with: ''
      fill_in 'Password confirmation', with: ''
      click_button 'Save changes'
    end
    subject { page }
    it `is not unsuccessful edit` do
      #is_expected.to have_current_path "users/edit"
      is_expected.to have_selector('.alert', text: 'The form contains 4 errors.')
    end
  end
end
