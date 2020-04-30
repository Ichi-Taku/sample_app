require 'rails_helper'

RSpec.describe "Followings", type: :request do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:other_user) }
  let!(:user3) { create(:taro) }
  before do
    create_list(:post1, 30, user_id: user1.id)
    create_list(:post2, 30, user_id: user2.id)
    create_list(:post3, 30, user_id: user3.id)

    Relationship.create(follower_id: user1.id, followed_id: user2.id)
    Relationship.create(follower_id: user2.id, followed_id: user3.id)
    Relationship.create(follower_id: user3.id, followed_id: user1.id)
    allow_any_instance_of(ActionDispatch::Request)
        .to receive(:session).and_return(user_id: user1.id)
  end

  describe `following page` do
    before { get following_user_path(user1) }
    it `has folloing` do
      expect(user1.following.empty?).to eq false
      expect(response.body).to include user1.following.count.to_s
      user1.following.each do |user|
        expect(response.body).to include user_path(user)
      end
    end
  end

  describe `followers page` do
    before { get followers_user_path(user1) }
    it `has folloing` do
      expect(user1.followers.empty?).to eq false
      expect(response.body).to include user1.followers.count.to_s
      user1.followers.each do |user|
        expect(response.body).to include user_path(user)
      end
    end
  end
end
