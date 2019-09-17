class CsvController < ApplicationController
  def download
    transaction = CsvExport.new.call(pro: params[:project], user: current_user)
    if transaction.success?
      send_data File.read(transaction.success[:filepath]), :type => 'text/csv', :disposition => "attachment; filename=contributors.csv"
    else
      flash[:error] = transaction.failure[:error]
    end
  end
end
