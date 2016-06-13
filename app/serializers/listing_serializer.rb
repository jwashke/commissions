class ListingSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :list_price, :address, :mls_number

  def address
    "#{object.street_number} #{object.street_name} #{object.city} #{object.state} #{object.zip_code}"
  end
end
