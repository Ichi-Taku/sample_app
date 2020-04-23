require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let!(:user) { create(:user) }
  before do
    remember(user)
  end
  context `session is nil but cookies is by_truht` do
    it `returns right user` do
      expect(current_user).to eq user
    end
  end
  context `remember_digest does not equal remember_token` do
    before { user.update_attribute(:remember_digest, User.digest(User.new_token)) }
    it { expect(current_user).to eq nil }
  end
end
