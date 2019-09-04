require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context '#create' do
    let(:user) { create(:user) }
    it 'valide la transaction' do
      user.email = nil
      expect(user.save).to eq(false)
    end
    it 'doit envoyer un mail de bienvenue' do
      expect(PostMailer).to receive(:new_message).with(user.email, 'Testing letter_opener_web')
      user.save
    end
  end
end
