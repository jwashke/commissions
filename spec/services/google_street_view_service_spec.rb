require 'rails_helper'

RSpec.describe StreetViewImageService do
  describe "#get_image" do
    it "returns a street view image" do
      VCR.use_cassette("#get_image") do
        response = StreetViewImageService.new.get_image("40", "-110")

        expect(response.headers["content-length"]).to eq("5307")
        expect(response.headers["content-type"]).to eq("image/jpeg")
      end
    end
  end
end
