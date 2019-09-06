class Project < ApplicationRecord
  belongs_to :category
  include ImageUploader::Attachment.new(:image)
  include LandUploader::Attachment.new(:thumb)
end
