require 'rails_helper'
RSpec.describe CreateUser, type: :transactions do
  context '#create transaction' do
    let(:user) { create(:user) }
    it 'validate transaction' do
      user.email = nil
      expect(user.save).to eq(false)
    end
    it 'not receive email' do
      expect(PostMailer).not_to receive(:new_message)
      user.save
    end
    it 'need to receive email' do
      expect(PostMailer).to receive(:new_message).with(user.email)
      user.save
    end
  end
end
