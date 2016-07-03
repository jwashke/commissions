class Admin::ImportsController < Admin::BaseController

  def show
    @import = Import.last
  end

  def new
  end

  def create
    Import.create(
      time_started: Time.now,
      prev_quantity_active: Listing.where(status: "Active").count
    )
    new_listings = SmarterCSV.process(params[:file].path)
    json_listings = new_listings.to_json

    CsvWorker.perform_async(json_listings)
    redirect_to admin_latest_import_path
  end
end
