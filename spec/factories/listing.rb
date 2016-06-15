FactoryGirl.define do
  factory :listing do
    sequence :mls_number do |n|
      n
    end
    street_number "123"
    street_name "fake"
    street_type "street"
    list_price 100
    buyer_agency_compensation 2.8
    listing_agent_name "name"
    listing_agent_phone "9099106885"
    listing_agent_email "name@example.com"
    public_remarks "This is a nice house"
  end
end
