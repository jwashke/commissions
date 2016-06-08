class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :mls_number
      t.datetime :last_change_timestamp
      t.string :property_type
      t.string :status
      t.integer :list_price
      t.string :street_number
      t.string :street_dir
      t.string :street_name
      t.string :street_type
      t.string :unit_number
      t.string :building_number
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :county
      t.string :parcel_number
      t.string :locale
      t.string :complex_name

      t.timestamps null: false
    end
  end
end
