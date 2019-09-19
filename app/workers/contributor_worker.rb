class ContributorWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(project, user)
    transaction = CsvExport.new.call(pro: project.to_i, user: User.find(user))
    if transaction.success?
      Rails.application.routes.url_helpers.send_data_url(id: 1, data: transaction.success[:filepath])
    else
      flash[:error] = transaction.failure[:error]
    end
  end
end
