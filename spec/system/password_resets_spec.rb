require 'rails_helper'

RSpec.describe "PasswordResets", type: :system do
  
  describe `#create` do
  let!(:user) { create(:user) }
  before do
    visit new_password_reset_path
  end
  subject { page }
    it `shows error flash` do
      fill_in 'Email', with: ""
      click_button 'Submit'
      is_expected.to have_selector('.alert-danger')
    end
    it `shows success flash` do
      fill_in 'Email', with: user.email
      click_button 'Submit'
      is_expected.to have_selector('.alert')
      is_expected.to have_current_path(root_path)
      expect(user.reset_digest).not_to eq user.reload.reset_digest
      expect(ActionMailer::Base.deliveries.size).to eq 1
    end
  end


end
