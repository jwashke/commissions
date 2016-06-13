require 'rails_helper'

RSpec.describe Api::V1::ListingsController do
  describe "GET Index", type: :controller do
    it "can visit index" do
      user = create(:signed_user)
      sign_in user
      listing1 = Listing.create(mls_number: 1234567, status: "Active")
      listing2 = Listing.create(mls_number: 9876543, status: "inactive")

      get "index", format: :json
      parsed = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed.first["mls_number"]).to eq(listing1.mls_number)
      expect(parsed.count).to eq(1)
    end
  end
end
