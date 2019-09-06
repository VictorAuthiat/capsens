class Project < ApplicationRecord
  belongs_to :category
  include LandUploader::Attachment.new(:image)
  # include LandUploader::Attachment.new(:thumb)
end
