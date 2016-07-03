class Admin::ImportsController < Admin::BaseController

  def show
    @import = Import.last
  end

  def new
  end

  def create
    json_listings = CSVService.get_listings(params[:file].path)
    import_id = Import.last.id
    CSVWorker.perform_async(json_listings, import_id)
    redirect_to admin_latest_import_path
  end
end
