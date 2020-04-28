require 'rails_helper'

RSpec.describe "MicropostInterfaces", type: :request do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:other_user) }
  let!(:user3) { create(:taro) }

  before do
    allow_any_instance_of(ActionDispatch::Request)
        .to receive(:session).and_return(user_id: user1.id)
    #session[:user_id] = user_id
    get root_path
  end

  describe `interface` do
    context `invalid post` do
      it `shows error_massage` do
        expect do
          post microposts_path, params: { micropost: { content: '' } }
        end.not_to change { Micropost.count }
        expect(response.body).to include "error_explanation"
      end
    end
    context `valid post` do
      let!(:content) { "This micropost really ties the room together" }
      let!(:picture) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/rails.png'), 'image/png') }
      it `shows post text` do
        expect do
          post microposts_path, params: { micropost: { content: content,
                                                       picture: picture} }
        end.to change{ Micropost.count }
        expect(response).to redirect_to root_url
        get root_url
        expect(response.body).to include content
      end
    end

    context `delete post` do
      let!(:first_post) { user1.microposts.paginate(page: 1).first }
      it `counts decrease` do
        expect(response.body).to include "delete"
        expect do
          delete micropost_path(first_post)
        end.to change{ Micropost.count }
      end
    end
  end
end
