require 'rails_helper'

RSpec.describe User, type: :model do
  #facrory botが存在するかのテストです
  it 'has a valid factory bot' do
    expect(build(:user)).to be_valid
  end


  describe `validations` do
    it {is_expected.to validate_presence_of(:name)}
  end
end
