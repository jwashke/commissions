require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET #index" do
    context "As a logged in user with signed docs" do
      it "redirects to the listings index" do
        user = create(:signed_user)
        sign_in user

        get :index

        expect(response.status).to eq(302)
        expect(response).to redirect_to(listings_path)
      end
    end

    context "As a logged in user with unsigned docs" do
      it "redirects to the document signing page" do
        user = create(:user)
        sign_in user

        get :index

        expect(response.status).to eq(302)
        expect(response).to redirect_to(signing_path)
      end
    end

    context "As a guest user" do
      it "renders the template with 200 ok" do
        get :index

        expect(response.status).to eq(200)
        expect(response).to render_template(:index)
      end
    end
  end
end
