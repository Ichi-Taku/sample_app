require 'rails_helper'

RSpec.describe "SiteLayouts", type: :system do
  before do
    visit(root_path)
  end
  context `access to root_path` do
    
    it `has root_path` do
      expect(page).to have_link nil, href: root_path, count: 2
    end

    it `has help_path` do
      expect(page).to have_link nil, href: help_path
    end

    it `has about_path` do
      expect(page).to have_link nil, href: about_path
    end

    it `has contact_path` do
      expect(page).to have_link nil, href: contact_path
    end
  end
end
