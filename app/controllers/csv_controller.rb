class CsvController < ApplicationController
  before_action :fetch_project, only: :download

  def download
    transaction = CsvExport.new.call(pro: params[:project])
    if transaction.success?
      send_data(File.read(
        transaction.success[:file].path
      ), type: 'text/csv', disposition: 'attachment; filename=contributors.csv')
      transaction.success[:file].close
      transaction.success[:file].unlink
    else
      flash[:error] = transaction.failure[:error]
      redirect_to admin_project_path(@project_id)
    end
  end

  private

  def fetch_project
    @project_id = params[:project]
  end
end
