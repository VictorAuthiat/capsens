class CsvController < ApplicationController
  before_action :fetch_project, only: :download

  def download
    ContributorWorker.new.perform(@project_id, current_admin_user.email)
    redirect_to admin_project_path(@project_id)
  end

  private

  def fetch_project
    @project_id = params[:project]
  end
end
