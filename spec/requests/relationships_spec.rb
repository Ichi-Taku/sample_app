require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:other_user) }

  before do
    Relationship.create(follower_id: user1.id, followed_id: user2.id)
  end

  describe `#create` do
    context `not login` do
      it `redirects to login_url` do
        expect { post relationships_path }.not_to change{ Relationship.count }
        expect(response).to redirect_to login_url
      end
    end
  end

  describe `#destroy` do
    context `not login` do
      it `redirects to login_url` do
        expect { delete relationship_path(Relationship.first) }.not_to change{ Relationship.count }
        expect(response).to redirect_to login_url
      end
    end
  end
end
