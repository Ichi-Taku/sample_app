require 'rails_helper'

RSpec.describe "AccessToUsers", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:other_user) }
  
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
        before do
          ActionMailer::Base.deliveries.clear
          post signup_path, params: { user: attributes_for(:user) }
        end
        subject { response }
        #it { expect(assigns(:user).activated?).to eq false }
        #it { expect(is_logged_in?).to eq false }
        it { expect(ActionMailer::Base.deliveries.size).to eq 1 }
        it { is_expected.to redirect_to root_path }
        it { is_expected.to have_http_status 302 }
        it { expect(is_logged_in?).to eq false }
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

  describe `should redirect edit when not logged in` do
    before { get edit_user_path(user) }
    subject { page }
    it `redirect to login_url` do
      expect(response).to redirect_to login_url
    end
  end

  describe `should redirect update when not logged in` do
    before { patch user_path(user), params: { user: { name: user.name,
                                              email: user.email } } }
    subject { page }
    it `redirect to login_url` do
      expect(response).to redirect_to login_url
    end
  end

  describe `#edit` do
    before do
      post login_path, params: { session: { email: other_user.email,
                                            password: other_user.password} }
    end
    context `should redirect edit when logged in as wrong user` do
      before { get edit_user_path(user) }
      it `redirect to root_url` do
        expect(response).to redirect_to root_url
      end
    end
  end

  describe `#update` do
    before do
      post login_path, params: { session: { email: other_user.email,
                                            password: other_user.password} }
    end
    context `should redirect update when logged in as wrong user` do
      before do
        patch user_path(user), params: { user: { name: user.name,
                                                  email: user.email } }
      end
      it `redirect to root_url` do
        expect(response).to redirect_to root_url
      end
    end
    context `other_user edited admin attribute` do
      before do
        patch user_path(other_user), params: {
                          user: { password:              "password",
                                  password_confirmation: "password",
                                  admin: 1 } }
      end
      it { expect(other_user.reload.admin?).to be_falsey }
    end
  end

  describe `#destroy` do
    context `not logged in user used destroy` do
      before { delete user_path(user) }
      it { expect(response).to redirect_to login_url }
    end

    context `not admin user used destroy` do
      before do
        post login_path, params: { session: { email: other_user.email,
                                              password: other_user.password} }
        delete user_path(user)
      end
      it { expect(response).to redirect_to root_url }
    end

    context `delete user` do
      before do
        post login_path, params: { session: { email: user.email,
                                              password: user.password} }
      end

      it { expect{delete user_path(other_user)}.to change(User, :count).by(-1) }
    end
  end

end
