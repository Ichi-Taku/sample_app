require 'rails_helper'

RSpec.describe "Microposts", type: :request do
  let!(:user) { create(:user) }
  let!(:micropost) { Micropost.create(content: "テスト", user: user) }
  
  describe `#create` do
    context `not logged in` do
      it `redirect to login_url` do
        expect do
          post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
        end.not_to change{ Micropost.count }
        expect(response).to redirect_to(login_url)
      end
    end
  end

  describe `#destroy` do
    context `not logged in` do
      it `redirect to login_url` do
        expect do
          delete micropost_path(micropost)
        end.not_to change{ Micropost.count }
        expect(response).to redirect_to(login_url)
      end
    end
    context `another user` do
      it `redirect to root_url` do
        expect do
          delete micropost_path(micropost)
        end.not_to change{ Micropost.count }
        expect(response).to redirect_to(login_url)
      end
    end
  end
end
