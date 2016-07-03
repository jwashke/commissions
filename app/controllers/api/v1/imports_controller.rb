class Api::V1::ImportsController < Api::V1::ApiController
  def show
    respond_with Import.last
  end
end
