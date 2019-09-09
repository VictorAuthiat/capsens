require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'validation tests' do
    let(:project) { create(:project) }
    it 'validate the presence of the project name' do
      project.name = nil
      expect(project.save).to eq(false)
    end
    it 'validate the presence of the project purpose' do
      project.purpose = nil
      expect(project.save).to eq(false)
    end
    it 'validate the presence of the project content' do
      project.purpose = nil
      expect(project.save).to eq(false)
    end
    it 'validate even if the project does not have short content' do
      project.short_content = nil
      expect(project.save).to eq(true)
    end
    it 'validate presence of picture' do
      project.image = nil
      expect(project.save).to eq(false)
    end
    it 'base : succes' do
      expect(project.save).to eq(true)
    end
  end
end
