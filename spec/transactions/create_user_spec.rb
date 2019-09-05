require 'rails_helper'
RSpec.describe CreateUser, type: :transactions do
  subject { CreateUser.new.call(user: user) }

  context '#create transaction' do
    let(:user) { create(:user) }
    it 'validate transaction' do
      user.email = nil
      expect(subject.class).to eq(Dry::Monads::Result::Failure)
    end
    it 'need to receive email' do
      expect(PostMailer).to receive_message_chain(:new_message, :deliver_now)
      subject
    end
  end
end
