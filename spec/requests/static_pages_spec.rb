require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  include ApplicationHelper
  context 'get #home' do
    before do
      get root_path
    end
		it `has 'Ruby on Rails Tutorial Sample App'` do
      expect(response.body).to include full_title("")
      #assert_select "title", base_title
		end
  end
  
  context 'get #help' do
    before do
      get help_path
    end
		it `has 'Help | Ruby on Rails Tutorial Sample App'` do
			expect(response.body).to include full_title("Help")
		end
  end

  context 'get #about' do
    before do
      get about_path
    end
		it `has 'About | Ruby on Rails Tutorial Sample App'` do
			expect(response.body).to include full_title("About")
		end
  end

  context 'get #help' do
    before do
      get contact_path
    end
		it `has 'Contact | Ruby on Rails Tutorial Sample App'` do
			expect(response.body).to include full_title("Contact")
		end
  end
end
