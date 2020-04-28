require 'rails_helper'

RSpec.describe "MicropostInterfaces", type: :request do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:other_user) }
  let!(:user3) { create(:taro) }
  let!(:content) { "This micropost really ties the room together" }
  let!(:picture) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/rails.png'), 'image/png') }

  before do
    allow_any_instance_of(ActionDispatch::Request)
        .to receive(:session).and_return(user_id: user1.id)
    get root_path
  end

  describe `micropost interface` do
    context `invalid post` do
      it `shows error_massage` do
        expect do
          post microposts_path, params: { micropost: { content: '' } }
        end.not_to change { Micropost.count }
        expect(response.body).to include "error_explanation"
      end
    end

    context `valid post` do
      it `shows post text` do
        expect do
          post microposts_path, params: { micropost: { content: content,
                                                       picture: picture } }
        end.to change{ Micropost.count }
        expect(response).to redirect_to root_url
        get root_url
        expect(response.body).to include content
      end
    end

    context `delete post` do
      before do
          post microposts_path, params: { micropost: { content: content,
          picture: picture } }
          get root_url
      end
      let!(:first_post) { user1.microposts.paginate(page: 1).first }
      it `counts decrease` do
        expect(response.body).to include "You sure?"
        expect do
          delete micropost_path(first_post)
        end.to change{ Micropost.count }.by(-1)
      end
    end

    context `another users page` do
      before { get user_path(user2) }
      #deleteはログアウト時にも使わている
      it { expect(response.body).not_to include "You sure?" }
    end
  end

  describe `micropost sidebar count` do
    before do
      allow_any_instance_of(ActionDispatch::Request)
          .to receive(:session).and_return(user_id: user3.id)
      get root_path
    end
    subject { response.body }
    context `does not have micropost` do
      it `has no micropost` do
        is_expected.to include "0 microposts"
      end
    end
    context `have 1 micropost` do
      before do
        post microposts_path, params: { micropost: { content: content,
                                                     picture: picture } }
        get root_path
        end
      it `has 1 micropost` do
        is_expected.to include "1 micropost"
      end
    end
  end
end
