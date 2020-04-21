require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe `#full_title` do
    #include ApplicationHelper
    it `returns "Ruby on Rails Tutorial Sample App"` do
      expect(full_title("")).to eq "Ruby on Rails Tutorial Sample App"
    end
    it `returns "Help | Ruby on Rails Tutorial Sample App"` do
      expect(full_title("Help")).to eq "Help | Ruby on Rails Tutorial Sample App"
    end
  end
end
