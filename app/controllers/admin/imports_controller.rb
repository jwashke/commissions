class Admin::ImportsController < Admin::BaseController

  def show
    @import = Import.last
  end

  def new
  end

  def create
    Import.create(
      time_started: Time.now,
      prev_quantity_active: Listing.where(status: "Active").count,
      status: "processing"
    )

    import_id = Import.last.id
    CSVWorker.perform_async(params[:file].path, import_id)
    redirect_to admin_latest_import_path
  end
end
