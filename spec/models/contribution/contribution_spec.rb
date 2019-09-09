require 'rails_helper'

RSpec.describe Contribution, type: :model do
  context 'validation tests' do
    let(:contribution) { create(:contribution) }
    it 'validate the presence of amount_in_cents' do
      contribution.amount_in_cents = nil
      expect(contribution.save).to eq(false)
    end
    it 'base : succes' do
      expect(contribution.save).to eq(true)
    end
  end
end
