class Admin::ImportsController < Admin::BaseController

  def show
    @import = Import.last
  end

  def new
  end

  def create
    import = Import.create(
      time_started: Time.now,
      prev_quantity_active: Listing.where(status: "Active").count,
      status: "processing"
    )
    import_id = import.id
    json_listings = CSVService.get_listings(params[:file].path)
    CSVWorker.perform_async(json_listings, import_id)
    redirect_to admin_latest_import_path
  end
end
