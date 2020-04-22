require 'rails_helper'

RSpec.describe "AccessToUsers", type: :request do
  describe `signup_path"#new"` do
    it `responds successfully` do
      get signup_path
      expect(response).to have_http_status 200
    end
  end
  
  describe `Users #create` do
    context `POST valid request` do
      it `adds a user` do
        expect do
          post signup_path, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
      end
      context `added a user` do
        subject { response }
        before { post signup_path, params: { user: attributes_for(:user) } }
        #it { expect(assigns(:user).activated?).to eq false }
        #it { expect(is_logged_in?).to eq false }
        it { is_expected.to redirect_to root_path }
        it { is_expected.to have_http_status 302 }
      end
    end
    context `invalid request` do
      let(:user_params) do
        attributes_for(:user, name: '',
                              email: 'user@invalid',
                              password: '',
                              password_confirmation: '')
      end
      it `does not add a user` do
        expect do
          post signup_path, params: { user: user_params }
        end.to change(User, :count).by(0)
      end
    end
  end
end
