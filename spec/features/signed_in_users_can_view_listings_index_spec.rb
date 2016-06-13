require "rails_helper"

RSpec.feature "User can view listings index" do
  context "as a logged in user who has signed documents" do
    xit "they see all listings as markers on a map" do

    end
  end

  context "as a logged in user who has not signed documents" do
    xit "redirects them to the legal documents page" do

    end
  end

  context "as a guest user" do
    it "redirects them to the welcome page to sign in or create an account" do
      visit listings_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Login or Create an account to get started.")
    end
  end
end
