require 'rails_helper'

RSpec.describe ListingsController, type: :controller do

  describe "GET #index" do
    context "As a logged in user with signed docs" do
      it "returns 200 ok and renders the template" do
        user = create(:signed_user)
        sign_in user

        get :index

        expect(response.status).to eq(200)
        expect(response).to render_template(:index)
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
      it "redirects to the welcome page" do
        get :index

        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #show" do
    context "As a logged in user with signed docs" do
      it "assigns the listing and renders the template" do
        listing = create(:listing)
        user = create(:signed_user)
        sign_in user

        get :show, mls_number: listing.mls_number

        expect(response.status).to eq(200)
        expect(assigns(:listing)).to eq(listing)
        expect(response).to render_template(:show)
      end
    end

    context "As a logged in user with unsigned docs" do
      it "redirects to the document signing page" do
        listing = create(:listing)
        user = create(:user)
        sign_in user

        get :show, mls_number: listing.mls_number

        expect(response.status).to eq(302)
        expect(response).to redirect_to(signing_path)
      end
    end

    context "As a guest user" do
      it "redirects to the welcome page" do
        listing = create(:listing)

        get :show, mls_number: listing.mls_number

        expect(response).to redirect_to(root_path)
      end
    end
  end

end
