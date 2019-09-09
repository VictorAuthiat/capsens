require 'rails_helper'
RSpec.describe Counterpart, type: :model do
  context 'validation tests' do
    let(:counterpart) { create(:counterpart) }
    it 'validate the presence of amount_in_cents' do
      counterpart.amount_in_cents = nil
      expect(counterpart.save).to eq(false)
    end
    it 'base : succes' do
      expect(counterpart.save).to eq(true)
    end
  end
end
