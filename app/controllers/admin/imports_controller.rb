class Admin::ImportsController < Admin::BaseController

  def show
    @import = Import.last
  end

  def new
  end

  def create
    json_listings = CSVService.get_listings(params[:file].path)
    CSVWorker.perform_async(json_listings)
    redirect_to admin_latest_import_path
  end
end
