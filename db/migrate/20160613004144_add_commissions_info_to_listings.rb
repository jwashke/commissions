class AddCommissionsInfoToListings < ActiveRecord::Migration
  def change
    add_column :listings, :total_baths, :string
    add_column :listings, :total_bedrooms, :string
    add_column :listings, :square_feet, :string
    add_column :listings, :lot_square_acres, :string
    add_column :listings, :buyer_agency_compensation, :float
    add_column :listings, :listing_agent_name, :string
    add_column :listings, :listing_agent_phone, :string
    add_column :listings, :listing_agent_email, :string
    add_column :listings, :transaction_broker_compensation, :float
    add_column :listings, :streetview_available, :boolean
  end
end
