class ListingSerializer < ActiveModel::Serializer
  include ActionView::Helpers::NumberHelper

  attributes :id, :latitude, :longitude, :price, :address, :mls_number,
             :city, :property_type, :total_baths, :total_bedrooms, :commission

  def address
    "#{object.street_number} #{object.street_dir} #{object.street_name} #{object.street_type} #{object.city} #{object.state} #{object.zip_code}"
  end

  def commission
    amount = object.list_price * (object.buyer_agency_compensation.to_f / 100 )
    number_to_currency(amount, precision: 2)
  end

  def price
    number_to_currency(object.list_price, precision: 2)
  end
end
