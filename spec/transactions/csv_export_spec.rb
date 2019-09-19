require 'rails_helper'
include ActiveJob::TestHelper
RSpec.describe CsvExport, type: :transactions do
  subject { CsvExport.new.call(pro: project.id, user: user) }
  let(:user) { create(:user) }
  let(:project) { create(:project) }

  context '#create transaction' do
    it 'need to receive email' do
      expect(PostMailer).to receive_message_chain(:new_csv, :deliver_later)
      subject
    end
  end
end
