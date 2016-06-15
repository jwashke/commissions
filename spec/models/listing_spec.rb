require 'rails_helper'

RSpec.describe Listing, type: :model do
  it "gets all active listings either through a cache or activerecord" do
    listing1 = Listing.create(mls_number: 123456, status: "Active")
    listing2 = Listing.create(mls_number: 987654, status: "inactive")


    result = Listing.all_cached

    expect(result).to eq([listing1])
  end

  it "can import a csv" do
    Listing.new_import(File.open("spec/data/test.csv", "r"))

    expect(Listing.all.count).to eq(4)
  end
end
