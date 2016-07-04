require 'rails_helper'

RSpec.describe Listing, type: :model do
  it "gets all active listings either through a cache or activerecord" do
    listing1 = Listing.create(mls_number: 123456, status: "Active")
    listing2 = Listing.create(mls_number: 987654, status: "inactive")


    result = Listing.all_cached

    expect(result).to eq([listing1])
  end

  it "can find out if a streetview image is available" do
    VCR.use_cassette("store_feature#show") do
      listing1 = Listing.create(latitude: 1, longitude: 1)
      listing2 = Listing.create(latitude: 39.781505, longitude: -104.952024)

      result1 = listing1.streetview_available?
      result2 = listing2.streetview_available?

      expect(result1).to eq(false)
      expect(result2).to eq(true)
    end
  end
end
