require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }

  describe `shows following and followers` do
    context `not logged in` do
      subject { response }
      it `redirects login_url` do
        get following_user_path(user)
        is_expected.to redirect_to login_url
        get followers_user_path(user)
        is_expected.to redirect_to login_url
      end
    end
  end
end
