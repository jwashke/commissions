require 'rails_helper'

RSpec.describe SigningController, type: :controller do
  describe "GET #show" do
    context "as a user with unsigned docs" do
      it "renders the template" do
        user = create(:user)
        sign_in user

        get :new

        expect(response.status).to eq(200)
        expect(response).to render_template(:new)
      end
    end

    context "as a user with signed docs" do
      it "redirects to the listing path" do
        user = create(:signed_user)
        sign_in user

        get :new

        expect(response.status).to eq(302)
        expect(response).to redirect_to(listings_path)
      end
    end

    context "as a guest user" do
      it "redirects to the root path" do
        get :new

        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
