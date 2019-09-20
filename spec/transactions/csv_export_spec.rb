require 'rails_helper'
RSpec.describe CsvExport, type: :transactions do
  ActiveJob::Base.queue_adapter = :test
  subject { CsvExport.new.call(pro: project.id, user: user) }
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  context 'email is enqueued to be delivered later' do
    it 'need to receive email' do
      expect { PostMailer.new_csv.deliver_later }.to have_enqueued_job.on_queue('mailers')
      subject
    end
  end
end
