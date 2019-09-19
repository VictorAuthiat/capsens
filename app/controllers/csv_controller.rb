class CsvController < ApplicationController
  before_action :fetch_project, only: :download

  def download
    ContributorWorker.perform_async(@project_id, current_user.id)
    redirect_to admin_project_path(@project_id)
  end

  private

  def fetch_project
    @project_id = params[:project]
  end
end
