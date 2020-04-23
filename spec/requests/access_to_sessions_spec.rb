require 'rails_helper'

RSpec.describe "AccessToSessions", type: :request do
  let!(:user) { create(:user) }
  describe 'POST #create' do
    it 'log in and redirect to detail page' do
      post login_path, params: { session: { email: user.email,
                                            password: user.password } }
      expect(response).to redirect_to user_path(user)
      expect(is_logged_in?).to be_truthy
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
