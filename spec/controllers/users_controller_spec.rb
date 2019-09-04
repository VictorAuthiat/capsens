require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context '#create' do
    let(:user) { create(:user) }
    it 'valide la transaction' do
      user.email = nil
      expect(user.save).to eq(false)
    end
    it 'doit envoyer un mail de bienvenue' do

    end
  end
end
