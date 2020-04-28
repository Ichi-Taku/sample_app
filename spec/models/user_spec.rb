require 'rails_helper'

RSpec.describe User, type: :model do
  #facrory botが存在するかのテスト
  it `has a valid factory bot` do
    expect(build(:user)).to be_valid
  end


  describe `validations` do
    it { is_expected.to validate_presence_of(:name)}
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_length_of(:email).is_at_most(255) }
    it do
      is_expected.to allow_values('first.last@foo.jp',
                                  'user@example.com',
                                  'USER@foo.COM',
                                  'A_US-ER@foo.bar.org',
                                  'alice+bob@baz.cn').for(:email)
    end
    it do
      is_expected.to_not allow_values('user@example,com',
                                      'user_at_foo.org',
                                      'user.name@example.',
                                      'foo@bar_baz.com',
                                      'foo@bar+baz.com').for(:email)
    end
    describe `validate unique email` do
      let!(:user) {create(:user, email: "duplicatemail@example.com")}
      it `is invalid with a duplicate email` do
        user = build(:user, email: 'duplicatemail@example.com')
        expect(user).to_not be_valid
      end
      it `is case insensitive in email` do
        user = build(:user, email: 'DUPLICATEMAIL@EXAMPLE.COM')
        expect(user).to_not be_valid
      end
    end
    describe `before save` do
      describe `#email_downcase` do
        let!(:user) { create(:user, email: 'TESTMAIL@EXAMPLE.COM') }
        it `saved email to downcase` do
          expect(user.reload.email).to eq "testmail@example.com"
        end
      end
    end
    it `is invalid with a blank password` do
      user = build(:user, password: ' ' * 6)
      expect(user).to_not be_valid
    end
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  context `does not exist remember_digest` do
    let(:user) {create(:user)}
    subject { user.authenticated?(:remember, "") }
    it `does not have a remember_digest` do
      is_expected.to eq false
    end
  end

  context `a user has nil digest` do
    let(:user) {create(:user)}
    it { expect(user.authenticated?(:remember, '')).to eq false }
  end

  context `user was destroyed` do
    let!(:user) { create(:user) }
    before { user.microposts.create!(content: "Lorem ipsum") }
    it `associate user` do
      expect do
        user.destroy
      end.to change(Micropost, :count).by(-1)
    end
  end

  describe `follow and unfollow` do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:other_user) }
    it { expect(user1.following?(user2)).to eq false }
    it do
      user1.follow(user2)
      expect(user1.following?(user2)).to eq true
      expect(user2.followers.include?(user1)).to eq true
    end
  end

end
