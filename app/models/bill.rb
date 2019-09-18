class Bill < ApplicationRecord
  belongs_to :user
  belongs_to :contribution
  belongs_to :project
  serialize :content
end
