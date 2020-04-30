require 'rails_helper'

RSpec.describe "Followings", type: :system do
  let!(:user) { create(:user, :with_post) }
  let!(:user2) { create(:other_user, :with_post) }
  let!(:user3) { create(:taro, :with_post) }
end
