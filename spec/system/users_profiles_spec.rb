require 'rails_helper'

RSpec.describe "UsersProfiles", type: :system do
  let!(:user) { create(:user) }
  before { visit user_path(user) }

  describe `profile display` do
    subject { page }
    
    it { is_expected.to have_title(full_title(user.name)) }
    it { is_expected.to have_selector("h1", text: user.name) }
    it { is_expected.to have_selector("img.gravatar") }
    it { is_expected.to have_content(user.microposts.count.to_s) }
    #it { is_expected.to have_selector("div.pagination") }
    
  end
end
