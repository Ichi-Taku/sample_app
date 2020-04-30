require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user, :with_post) }
  let!(:user2) { create(:other_user, :with_post) }
  let!(:user3) { create(:taro, :with_post) }
  before do
    Relationship.create(follower_id: user.id, followed_id: user3.id)
    Relationship.create(follower_id: user2.id, followed_id: user3.id)
    Relationship.create(follower_id: user3.id, followed_id: user.id)
  end


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
