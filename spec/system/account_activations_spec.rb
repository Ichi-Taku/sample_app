require 'rails_helper'

RSpec.describe "AccountActivations", type: :system do
  let!(:falsy_user) { create(:falsy_user) }
=begin 
  before do
    visit signup_path
    fill_in 'Name', with: falsy_user.name
    fill_in 'Email', with: falsy_user.email
    fill_in 'UserID', with: falsy_user.unique_id
    fill_in 'Password', with: falsy_user.password
    fill_in 'Password confirmation', with: falsy_user.password
    click_button 'Create my account'
    falsy_user.reload
  end
=end  
  describe `#edit` do
    subject { is_logged_in? }
    it { expect(falsy_user.activated?).to eq false }
    it `is not logged in` do
      visit login_path
      fill_in 'Email', with: falsy_user.email
      fill_in 'Password', with: falsy_user.password
      click_button 'Log in'
      is_expected.to be_falsey
      visit edit_account_activation_path("invalid token", email: falsy_user.email)
      is_expected.to be_falsey
      visit edit_account_activation_path(falsy_user.activation_token, email: 'wrong')
      is_expected.to be_falsey
      visit edit_account_activation_path(user.activation_token, email: falsy_user.email)
      falsy_user.reload
      is_expected.to be_truthy
    end
  end
end
