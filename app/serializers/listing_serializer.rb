class ListingSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :list_price, :address, :mls_number, :city, :property_type, :total_baths, :total_bedrooms

  def address
    "#{object.street_number} #{object.street_dir} #{object.street_name} #{object.street_type} #{object.city} #{object.state} #{object.zip_code}"
  end
end
