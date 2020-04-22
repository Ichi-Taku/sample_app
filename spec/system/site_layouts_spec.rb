require 'rails_helper'

RSpec.describe "SiteLayouts", type: :system do
  context `access to root_path` do
    before do
      visit(root_path)
    end
    it `has root_path` do
      expect(page).to have_link , href: root_path, count: 2
    end

    it `has help_path` do
      expect(page).to have_link "Help", href: help_path
    end

    it `has about_path` do
      expect(page).to have_link "About", href: about_path
    end

    it `has contact_path` do
      expect(page).to have_link "Contact", href: contact_path
    end
  end

  context `access to signup_path` do
    before do
      visit(signup_path)
    end
    it `has "Sign up" title` do
      expect(page).to have_title full_title('Sign up')
    end
  end
end
