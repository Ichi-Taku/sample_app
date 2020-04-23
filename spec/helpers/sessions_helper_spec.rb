require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let!(:user) { create(:user) }
  before do
    remember(user)
  end
  context `session is nil` do
    it `returns right user` do
      expect(current_user).to eq user
    end
  end
end
