require 'rails_helper'

RSpec.describe Admin::ImportsController, type: :controller do
  describe "GET #show" do
    context "As a logged in admin" do
      it "assigns the import and renders the template" do
        user = create(:signed_user, admin: true)
        sign_in user

        get :show

        expect(response.status).to eq(200)
        expect(response).to render_template(:show)
      end
    end

    context "As a logged in non admin" do
      it "renders a 404 page" do
        user = create(:signed_user)
        sign_in user

        get :show

        expect(response.status).to eq(404)
        expect(response).to render_template(:file => "#{Rails.root}/public/404.html")
      end
    end

    context "As a guest user" do
      it "renders a 404 page" do
        get :show

        expect(response.status).to eq(404)
        expect(response).to render_template(:file => "#{Rails.root}/public/404.html")
      end
    end
  end

  describe "GET #new" do
    context "As a logged in admin" do
      it "renders the template" do
        user = create(:signed_user, admin: true)
        sign_in user

        get :new

        expect(response.status).to eq(200)
        expect(response).to render_template(:new)
      end
    end

    context "As a logged in non admin" do
      it "renders a 404 page" do
        user = create(:signed_user)
        sign_in user

        get :new

        expect(response.status).to eq(404)
        expect(response).to render_template(:file => "#{Rails.root}/public/404.html")
      end
    end

    context "As a guest user" do
      it "renders a 404 page" do
        get :new

        expect(response.status).to eq(404)
        expect(response).to render_template(:file => "#{Rails.root}/public/404.html")
      end
    end
  end

  describe "POST #create" do

    context "As a logged in non admin" do
      it "renders a 404 page" do
        user = create(:signed_user)
        sign_in user

        post :create

        expect(response.status).to eq(404)
        expect(response).to render_template(:file => "#{Rails.root}/public/404.html")
      end
    end

    context "As a guest user" do
      it "renders a 404 page" do
        post :create

        expect(response.status).to eq(404)
        expect(response).to render_template(:file => "#{Rails.root}/public/404.html")
      end
    end
  end
end
