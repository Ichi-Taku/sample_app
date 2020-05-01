require 'rails_helper'

RSpec.describe "AccessToSessions", type: :request do
  let!(:user) { create(:user) }
  let!(:falsy_user) { create(:falsy_user) }
  describe 'POST #create' do
    it 'log in and redirect to detail page' do
      post login_path, params: { session: { email: user.email,
                                            password: user.password } }
      expect(response).to redirect_to user_path(user)
      expect(is_logged_in?).to be_truthy
    end

    context `valid signup information with account activation` do
      before do

=begin         
        post signup_path, params: { session: { name: other_user.name,
                                              email: other_user.email,
                                              password: other_user.password,
                                              unique_id: other_user.unique_id,
                                              password_confirmation: other_user.password } }
      
=end
      end
      subject { is_logged_in? }
      it { expect(falsy_user.activated?).to eq false }
      it `is not logged in` do
        post login_path, params: { session: { email: falsy_user.email,
                                              password: falsy_user.password } }
        is_expected.to be_falsey
        get edit_account_activation_path("invalid token", email: falsy_user.email)
        is_expected.to be_falsey
        get edit_account_activation_path(falsy_user.activation_token, email: 'wrong')
        is_expected.to be_falsey
        get edit_account_activation_path(falsy_user.activation_token, email: falsy_user.email)
        #falsy_user.reload
        #is_expected.to be_truthy
      end

    end
  end

  describe 'DELETE #destroy' do
    it 'log out and redirect to root page' do
      delete logout_path
      expect(response).to redirect_to root_path
      expect(is_logged_in?).to be_falsey
    end
    
    context `after logout` do
      it `redirect to root_path` do
        delete logout_path
        expect(response).to redirect_to root_path
      end
    end
  end

  describe `Remember me` do
    context `POST remember_me as 1` do
      it `remembers cookies` do
        post login_path, params: { session: { email: user.email,
                                              password: user.password,
                                              remember_me: 1 } }
        expect(response.cookies['remember_token']).to be_truthy
      end
    end

    context `POST remember_me as 0` do
      it `does not remember cookies` do
        post login_path, params: { session: { email: user.email,
                                              password: user.password,
                                              remember_me: 0 } }
        expect(response.cookies['remember_token']).to eq nil
      end
    end
  end

end
