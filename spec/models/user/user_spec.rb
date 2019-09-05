require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    let(:user) { create(:user, email: 'test-transaction@capsens.eu') }
    it 'validate the presence of an email' do
      user.email = nil
      expect(user.save).to eq(false)
    end
    it 'base : succes' do
      expect(user.save).to eq(true)
    end
  end
end
