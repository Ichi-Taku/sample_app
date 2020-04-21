require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  let(:base_title) {"Ruby on Rails Tutorial Sample App"}
  
  context 'get #home' do
    before do
      get root_path
    end
		it `has 'Ruby on Rails Tutorial Sample App'` do
      expect(response.body).to include base_title
      #assert_select "title", base_title
		end
  end
  
  context 'get #help' do
    before do
      get help_path
    end
		it `has 'Help | Ruby on Rails Tutorial Sample App'` do
			expect(response.body).to include "Help | #{base_title}"
		end
  end

  context 'get #about' do
    before do
      get about_path
    end
		it `has 'About | Ruby on Rails Tutorial Sample App'` do
			expect(response.body).to include "About | #{base_title}"
		end
  end

  context 'get #help' do
    before do
      get contact_path
    end
		it `has 'Contact | Ruby on Rails Tutorial Sample App'` do
			expect(response.body).to include "Contact | #{base_title}"
		end
  end
end
