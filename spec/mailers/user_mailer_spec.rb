require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let!(:user) { build(:user, activation_token: User.new_token) }
  let!(:mail) { UserMailer.account_activation(user) }

  describe `#account_activation` do
    it { expect(mail.subject).to eq "Account activation" }
    it { expect(mail.to).to eq [user.email] }
    it { expect(mail.from).to eq ["noreply@example.com"] }
    it { expect(mail.body.encoded).to include user.name }
    it { expect(mail.body.encoded).to include user.activation_token }
    it { expect(mail.body.encoded).to include CGI.escape(user.email) }
  end
end
