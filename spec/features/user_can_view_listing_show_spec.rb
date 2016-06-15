require "rails_helper"

RSpec.feature "User can view listings show" do
  context "as a logged in user who has signed documents" do
    it "they see the commission info and summary of the house" do
      user = create(:signed_user)
      login_as user, scope: :user
      listing = create(:listing)

      visit listing_path(listing.mls_number)

      expect(current_path).to eq(listing_path(listing.mls_number))
      expect(page).to have_content(listing.buyer_agency_compensation)
      expect(page).to have_content(listing.listing_agent_name)
      expect(page).to have_content(listing.listing_agent_phone)
      expect(page).to have_content(listing.listing_agent_email)
      expect(page).to have_content(listing.public_remarks)
    end
  end

  context "as a logged in user who has not signed documents" do
    it "redirects them to the legal documents page" do
      user = create(:user)
      login_as user, scope: :user
      listing = create(:listing)

      visit listing_path(listing)

      expect(current_path).to eq(signing_path)
    end
  end

  context "as a guest user" do
    it "redirects them to the welcome page to sign in or create an account" do
      listing = create(:listing)

      visit listing_path(listing)

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Login or Create an account to get started.")
    end
  end
end
