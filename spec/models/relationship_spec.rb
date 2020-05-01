require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:other_user) }
  let!(:relationship) { Relationship.new(follower_id: user1.id,
                                         followed_id: user2.id) }
  
  describe `validations` do
    context `should be valid` do
      it { expect(relationship).to validate_presence_of(:follower_id) }
      it { expect(relationship).to validate_presence_of(:followed_id) }
    end
    context `should require a follower_id` do
      let!(:bad_relationship) { Relationship.new(follower_id: nil,
                                             followed_id: user2.id) }
      it { expect(bad_relationship).not_to be_valid }
    end
    context `should require a followed_id` do
      let!(:bad_relationship) { Relationship.new(follower_id: user1.id,
                                             followed_id: nil) }
      it { expect(bad_relationship).not_to be_valid }
    end
  end
end
