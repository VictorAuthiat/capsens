class WorkerController < ApplicationController
  def send_data
    send_data File.read(
      params[:data]
    ), type: 'text/csv', disposition: 'attachment; filename=contributors.csv'
  end
end
