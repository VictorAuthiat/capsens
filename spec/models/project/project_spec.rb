require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'validation tests' do
    let(:user) { create(:user, email: 'test-transaction@capsens.eu') }
    let(:category) { create(:category, name: 'bobotte') }
    let(:project) { create(:project, category_id: category.id, name: 'bobo-test-project') }
    let(:counterpart) { create(:counterpart, project_id: project.id, name: 'counterpart') }
    let(:contribution) { create(:contribution, project_id: project.id, counterpart_id: counterpart.id, user_id: user.id, amount_in_cents: 100)}
    it 'validate the presence of a name' do
      project.name = nil
      expect(project.save).to eq(false)
    end
    it 'base : succes' do
      expect(project.save).to eq(true)
    end
    it 'initial state : draft' do
      expect(project.aasm_state).to eq('draft')
    end
    it 'upgoing conditions:' do
      project.image_data = nil
      expect(project.upgoing_needed?).to eq(false)
    end
    it 'second state => upgoing conditions:' do
      project.content = 'content'
      project.short_content = 'short_content'
      project.purpose = 10_000
      project.image_data = '../../fixtures/sample_images/project/land_pictures/food1.jpeg'
      expect(project.upgoing_needed?).to eq(true)
    end
    it 'ongoing conditions:' do
      expect(project.ongoing_needed?).to eq(false)
    end
    it 'third state => ongoing conditions:' do
      expect(project.ongoing_needed?).to eq(true)
    end
  end
end
