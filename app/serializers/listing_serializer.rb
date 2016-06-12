class ListingSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :list_price, :address

  def address
    "#{object.street_number} #{object.street_dir} #{object.street_name} #{object.street_type} #{object.city} #{object.state} #{object.zip_code}"
  end
end
