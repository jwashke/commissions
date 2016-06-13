class ListingShow < SimpleDelegator
  def address_line_one
    "#{street_number} #{street_name} #{street_type}"
  end

  def address_line_two
    "#{city} #{state} #{zip_code}"
  end
end
