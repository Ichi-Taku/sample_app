require 'rails_helper'

RSpec.describe "Followings", type: :system do
  let!(:user) { create(:user, :with_post) }
  let!(:user2) { create(:other_user, :with_post) }
  let!(:user3) { create(:taro, :with_post) }
  before do
    Relationship.create(follower_id: user.id, followed_id: user3.id)
    Relationship.create(follower_id: user2.id, followed_id: user3.id)
    Relationship.create(follower_id: user3.id, followed_id: user.id)
  end

  describe `following page` do
    it ``
  end
end
