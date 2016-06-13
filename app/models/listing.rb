class Listing < ActiveRecord::Base

  def self.all_cached
    Rails.cache.fetch('listings') do
      self.where(status: "Active")
    end
  end
end
