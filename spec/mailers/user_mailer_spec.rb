require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  describe `#account_activation` do
    let!(:user) { build(:user, activation_token: User.new_token) }
    let!(:mail) { UserMailer.account_activation(user) }
    it { expect(mail.subject).to eq "Account activation" }
    it { expect(mail.to).to eq [user.email] }
    it { expect(mail.from).to eq ["noreply@example.com"] }
    it { expect(mail.body.encoded).to include user.name }
    it { expect(mail.body.encoded).to include user.activation_token }
    it { expect(mail.body.encoded).to include CGI.escape(user.email) }
  end

  describe `#password_reset` do
    let!(:user) { build(:user, reset_token: User.new_token) }
    let!(:mail) { UserMailer.password_reset(user) }
    it { expect(mail.subject).to eq "Password reset" }
    it { expect(mail.to).to eq [user.email] }
    it { expect(mail.from).to eq ["noreply@example.com"] }
    it { expect(mail.body.encoded).to include user.reset_token }
    it { expect(mail.body.encoded).to include CGI.escape(user.email) }
  end
end
