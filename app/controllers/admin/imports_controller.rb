class Admin::ImportsController < Admin::BaseController

  def show
    @import = Import.last
  end

  def new
  end

  def create
    Listing.new_import(params[:file])
    redirect_to admin_latest_import_path
  end

end
