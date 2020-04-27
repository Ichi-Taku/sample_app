require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let!(:user) { create(:user) }
  let!(:micropost) { user.microposts.build(content: "Lorem ipsum") }
  let!(:r_micropost) { user.microposts.create(content: "recent_post") }

  describe `validations` do
    #subject { user.microposts.build(content: "Lorem ipsum") }
    it { expect(micropost).to validate_presence_of(:content) }
    it do
      micropost.content = nil
      expect(micropost).to validate_presence_of(:content)
    end
    it do
      micropost.content = "   "
      expect(micropost).to validate_presence_of(:content)
    end
    it do
      micropost.content = "a" * 141
      expect(micropost).to validate_presence_of(:content)
    end
  end

  describe `order` do
    it { expect(r_micropost).to eq Micropost.first }
  end
end
