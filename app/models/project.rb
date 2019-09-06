class Project < ApplicationRecord
  belongs_to :category
  include LandUploader::Attachment.new(:image)
  has_many :counterparts, dependent: :destroy
  has_many :contributions, dependent: :destroy
end
